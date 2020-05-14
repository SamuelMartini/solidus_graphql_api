# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    module Interfaces
      module PaymentSource
        include Types::Base::Interface

        orphan_types(*SolidusGraphqlApi.configuration.payment_sources.map(&:constantize))

        description <<-INFO
          Each `Spree::Payment` object has optional `source_type` and `source_id` attributes that point to a payment source model. 
          The listed source type is supplied by the `Spree::PaymentMethod` being used.

          More at [Solidus Guide](https://guides.solidus.io/developers/payments/payment-sources.html)
        INFO

        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :payment_method, Types::PaymentMethod, null: false
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
