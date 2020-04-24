# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :select_shipping_rate, mutation: :select_shipping_rate do
  let(:shipping_rate_id) { 'U3ByZWU6OlNoaXBwaW5nUmF0ZS0xMDAw' }
  let(:mutation_variables) {
    Hash[
      input: {
        shippingRateId: shipping_rate_id
      }
    ]
  }

  include_examples "checkout mutation authorization",
                   mutation_type: :selectShippingRate,
                   mutation_file: :select_shipping_rate

  context "when the current ability is authorized" do
    let(:current_order) { create(:order_with_line_items) }
    let(:shipping_rate) { create(:shipping_rate, cost: 20) }
    let(:user_errors) { subject[:data][:selectShippingRate][:errors] }
    let(:response_order) { subject[:data][:selectShippingRate][:order] }

    let(:mutation_context) {
      Hash[
        current_ability: Spree::Ability.new(nil),
        current_order: current_order,
        order_token: current_order.guest_token
      ]
    }

    before { current_order.shipments.first.shipping_rates << shipping_rate }

    context "when the given shipping rate id is wrong" do
      it { expect(subject[:data][:selectShippingRate]).to be_nil }
      it { expect(subject[:errors].first[:message]).to eq I18n.t(:'activerecord.exceptions.not_found') }
    end

    context "when the given shipping rate id is correct" do
      let(:selected_shipping_rate_id) { SolidusGraphqlApi::Schema.id_from_object(shipping_rate, nil, nil) }
      let(:shipping_rate_id) { selected_shipping_rate_id }

      it "selects the correct shipping rate" do
        selected_shipping_rate = response_order[:shipments][:nodes].first[:shippingRates][:nodes].find do
          |shipping_rate| shipping_rate[:selected]
        end

        expect( selected_shipping_rate[:id]).to eq(shipping_rate.id)
      end
    end
  end
end
