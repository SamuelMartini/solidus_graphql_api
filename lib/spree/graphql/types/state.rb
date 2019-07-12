module Spree
  module Graphql
    module Types
      class State < Base::RelayNode
        field :name, String, null: false
        field :abbr, String, null: false
        field :country, Types::Country, null: false, description: "Country"
        def country
          Loaders::AssociationLoader.for(Spree::State, :country).load(object)
        end
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      end
    end
  end
end
