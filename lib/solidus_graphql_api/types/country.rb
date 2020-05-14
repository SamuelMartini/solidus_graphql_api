# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Country < Base::RelayNode
      description <<-INFO
        Countries and states can affect both taxation and shipping on orders.
        So, an address must always link to a `Spree::Country` object.

        More at [Solidus Guide](https://guides.solidus.io/developers/users/addresses.html#countries-and-states)
      INFO

      field :iso_name, String, null: false
      field :iso, String, null: false
      field :iso3, String, null: false
      field :name, String, null: false
      field :numcode, Integer, null: false
      field :states, State.connection_type, null: false
      field :states_required, Boolean, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def states
        Queries::Country::StatesQuery.new(country: object).call
      end
    end
  end
end
