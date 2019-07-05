module Spree
  module Graphql
    module Types
      module Base
        class Field < GraphQL::Schema::Field
          def resolve_field(obj, args, ctx)
            resolve(obj, args, ctx)
          end
        end
      end
    end
  end
end
