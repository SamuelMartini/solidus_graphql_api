# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Price < Base::RelayNode
      description <<-INFO
        A store may have multiple `Spree::PaymentMethods` configured.
        Payment methods send payment information to a payment service provider.

        More at [Solidus Guide](https://guides.solidus.io/developers/payments/payment-methods.html#payment-methods)
      INFO

      field :amount, String, null: false
      field :country_iso, String, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :currency, Currency, null: false
      field :display_amount, String, null: false
      field :display_country, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def currency
        object.display_amount.currency
      end
    end
  end
end
