# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class User < Base::RelayNode
      description <<-INFO
        Stores require a User model in order to take advantage of all of Solidus's features.

        More at [Solidus Guide](https://guides.solidus.io/developers/users/custom-authentication.html)
      INFO

      field :addresses, Types::Address.connection_type, null: false
      field :bill_address, Types::Address, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :current_sign_in_at, GraphQL::Types::ISO8601DateTime, null: true
      field :default_address, Types::Address, null: true
      field :email, String, null: false
      field :last_sign_in_at, GraphQL::Types::ISO8601DateTime, null: true
      field :login, String, null: true
      field :ship_address, Types::Address, null: true
      field :sign_in_count, Integer, null: false
      field :spree_api_key, String, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :wallet, Types::WalletPaymentSource.connection_type, method: :wallet_payment_sources, null: false
    end
  end
end
