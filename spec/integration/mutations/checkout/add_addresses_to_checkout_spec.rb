# frozen_string_literal: true

require 'spec_helper'

RSpec.describe_mutation :add_addresses_to_checkout, mutation: :add_addresses_to_checkout do
  let(:country_id) { SolidusGraphqlApi::Schema.id_from_object(create(:country), nil, nil) }
  let(:address) {
    address = build_stubbed(:address).slice(:address1, :city, :phone, :zipcode)
    address[:countryId] = country_id
    address.transform_keys! { |key| key.camelize(:lower) }
  }
  let(:billing_address_firstname) { 'John' }
  let(:shipping_address_firstname) { 'Jane' }
  let(:mutation_variables) {
    Hash[
      input: {
        billingAddress: address.merge(firstname: billing_address_firstname),
        shippingAddress: address.merge(firstname: shipping_address_firstname)
      }
    ].tap do |variables|
      variables[:input][:shipToBillingAddress] = ship_to_billing_address if defined?(ship_to_billing_address)
    end
  }

  include_examples "checkout mutation authorization",
                   mutation_type: :addAddressesToCheckout,
                   mutation_file: :add_addresses_to_checkout

  context "when the current ability is authorized" do
    let(:current_order) { create(:order_with_line_items) }
    let(:user_errors) { subject[:data][:addAddressesToCheckout][:errors] }
    let(:response_order) { subject[:data][:addAddressesToCheckout][:order] }

    let(:mutation_context) {
      Hash[
        current_ability: Spree::Ability.new(nil),
        current_order: current_order,
        order_token: current_order.guest_token
      ]
    }

    context 'with wrong arguments' do
      let(:billing_address_firstname) { '' }

      it { expect(response_order[:number]).to eq(current_order.number) }

      if Gem::Requirement.new('>= 2.11.0.alpha').satisfied_by?(Spree.solidus_gem_version)
        it { expect(user_errors.first[:path]).to eq(["input", "order", "billAddress", "name"]) }
      else
        it { expect(user_errors.first[:path]).to eq(["input", "order", "billAddress", "firstname"]) }
      end

      it { expect(user_errors.first[:message]).to eq("can't be blank") }
      it { is_expected.to_not have_key(:errors) }
    end

    context 'with correct arguments' do
      context 'when shipToBillingAddress argument' do
        describe 'is true' do
          let(:ship_to_billing_address) { true }

          it { expect(response_order[:number]).to eq(current_order.number) }
          it { expect(response_order[:state]).to eq('address') }
          it { expect(response_order[:billingAddress][:firstname]).to eq(billing_address_firstname) }
          it { expect(response_order[:shippingAddress][:firstname]).to eq(billing_address_firstname) }
          it { expect(user_errors).to be_empty }
          it { is_expected.to_not have_key(:errors) }
        end

        describe 'is false' do
          let(:ship_to_billing_address) { false }

          it { expect(response_order[:number]).to eq(current_order.number) }
          it { expect(response_order[:state]).to eq('address') }
          it { expect(response_order[:billingAddress][:firstname]).to eq(billing_address_firstname) }
          it { expect(response_order[:shippingAddress][:firstname]).to eq(shipping_address_firstname) }
          it { expect(user_errors).to be_empty }
          it { is_expected.to_not have_key(:errors) }
        end

        describe 'is not present' do
          it { expect(response_order[:number]).to eq(current_order.number) }
          it { expect(response_order[:state]).to eq('address') }
          it { expect(response_order[:billingAddress][:firstname]).to eq(billing_address_firstname) }
          it { expect(response_order[:shippingAddress][:firstname]).to eq(shipping_address_firstname) }
          it { expect(user_errors).to be_empty }
          it { is_expected.to_not have_key(:errors) }
        end
      end
    end
  end
end
