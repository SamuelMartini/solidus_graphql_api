# frozen_string_literal: true

module Spree
  module Graphql
    module Types
      class Query < Types::Base::Object
        # Used by Relay to lookup objects by UUID:
        add_field(GraphQL::Types::Relay::NodeField)

        # Fetches a list of objects given a list of UUIDs
        add_field(GraphQL::Types::Relay::NodesField)
      end
    end
  end
end
