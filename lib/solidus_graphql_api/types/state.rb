# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class State < Base::RelayNode
      description <<-INFO
        Countries and states can affect both taxation and shipping on orders.
        So, an address must always link to a `Spree::Country` object.

        More at [Solidus Guide](https://guides.solidus.io/developers/users/addresses.html#countries-and-states)
      INFO

      field :name, String, null: false
      field :abbr, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
