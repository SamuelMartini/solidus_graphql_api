# frozen_string_literal: true

module SolidusGraphqlApi
  module Queries
    module Address
      class StateQuery
        attr_reader :address

        def initialize(address:)
          @address = address
        end

        def call
          SolidusGraphqlApi::BatchLoader.for(address, :state)
        end
      end
    end
  end
end
