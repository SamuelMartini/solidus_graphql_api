# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class SelectShippingRate < BaseMutation
        null true

        argument :shipping_rate_id, ID, required: true, loads: Types::ShippingRate

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(shipping_rate:)
          current_order.update(state: :delivery)

          Spree::OrderUpdateAttributes.new(current_order, update_params(shipping_rate: shipping_rate)).apply

          {
            errors: user_errors('order', current_order.errors),
            order: current_order.reload
          }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end

        private

        def update_params(shipping_rate:)
          {
            shipments_attributes: {
              id: shipping_rate.shipment.id,
              selected_shipping_rate_id: shipping_rate.id
            }
          }
        end
      end
    end
  end
end
