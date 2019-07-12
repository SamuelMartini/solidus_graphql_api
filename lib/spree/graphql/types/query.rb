module Spree
  module Graphql
    module Types
      class Query < Base::Object
        # Add root-level fields here.
        # They will be entry points for queries on your schema.

        # Used by Relay to lookup objects by UUID:
        field :node, field: GraphQL::Relay::Node.field

        # Fetches a list of objects given a list of IDs
        field :nodes, field: GraphQL::Relay::Node.plural_field

        field :countries, Types::Country.connection_type, null: false, description: "Supported Countries"
        def countries

        end
      end
    end
  end
end
