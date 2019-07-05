module Spree
  module Graphql
    class Schema < GraphQL::Schema
      mutation(Types::MutationType)
      query(Types::QueryType)
    end
  end
end
