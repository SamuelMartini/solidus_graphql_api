module Spree
  module Graphql
    class Schema < GraphQL::Schema
      mutation Types::Mutation
      query Types::Query
    end
  end
end
