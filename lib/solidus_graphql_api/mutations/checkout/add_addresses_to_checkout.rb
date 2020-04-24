# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class AddAddressesToCheckout < BaseCheckoutMutation
        argument :billing_address, Types::InputObjects::AddressInput, required: true
        argument :shipping_address, Types::InputObjects::AddressInput, required: false
        argument :ship_to_billing_address, Boolean, required: false, default_value: false

        private

        def update_params(billing_address:, shipping_address:, ship_to_billing_address:)
          {
            bill_address: Spree::Address.new(billing_address.to_h),
            ship_address: Spree::Address.new(shipping_address.to_h),
            use_billing: ship_to_billing_address
          }
        end

        def checkout_state
          :address
        end
      end
    end
  end
end
