# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class PaymentMethod < Base::RelayNode
      description <<-INFO
        A store may have multiple `Spree::PaymentMethods` configured.
        Payment methods send payment information to a payment service provider.

        More at [Solidus Guide](https://guides.solidus.io/developers/payments/payment-methods.html#payment-methods)
      INFO

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :description, String, null: true
      field :name, String, null: false
      field :position, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
