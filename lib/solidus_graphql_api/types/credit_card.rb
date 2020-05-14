# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class CreditCard < Base::RelayNode
      implements Types::Interfaces::PaymentSource

      description <<-INFO
       If your payment processing integration uses the `Spree::CreditCard` class for its payment source,
       take note that this model does not store all of the payment details.

        More at [Solidus Guide](https://guides.solidus.io/developers/payments/payment-sources.html#credit-cards)
      INFO

      field :address, Address, null: false
      field :cc_type, String, null: false
      field :last_digits, String, null: false
      field :month, String, null: false
      field :name, String, null: false
      field :year, String, null: false
    end
  end
end
