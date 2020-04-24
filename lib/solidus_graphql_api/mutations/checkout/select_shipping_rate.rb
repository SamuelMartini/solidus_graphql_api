# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class SelectShippingRate < BaseCheckoutMutation
        argument :shipping_rate_id, ID, required: true, loads: Types::ShippingRate

        private

        def update_params(shipping_rate:)
          {
            shipments_attributes: {
              id: shipping_rate.shipment.id,
              selected_shipping_rate_id: shipping_rate.id
            }
          }
        end

        def checkout_state
          :address
        end
      end
    end
  end
end
