# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class WalletPaymentSource < Base::RelayNode
      description <<-INFO
        Interface for accessing and updating a user's active "wallet".
        A Wallet is the *active* list of *reusable* payment sources that a user would like to
        choose from when placing orders.
      INFO

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :default, Boolean, null: false
      field :payment_source, Types::Interfaces::PaymentSource, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
