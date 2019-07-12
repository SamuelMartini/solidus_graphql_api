module Spree
  module Graphql
    class Schema < GraphQL::Schema
      mutation Types::Mutation
      query Types::Query

      # GraphQL::Batch setup:
      use GraphQL::Batch

      # Relay Object Identification:
      class << self
        # Return a string UUID for `object`
        def id_from_object(object, type_definition, query_ctx)
          ::GraphQL::Schema::UniqueWithinType.encode(object.class.name, object.id)
        end

        # Given a string UUID, find the object
        def object_from_id(id, query_ctx)
          class_name, item_id = GraphQL::Schema::UniqueWithinType.decode(id)

          Spree::Graphql::Loaders::RecordLoader.for(class_name.constantize).load(item_id.to_i)
          #::Object.const_get(class_name).find(item_id)
        end

        # Object Resolution
        def resolve_type(type, obj, ctx)
          Types.const_get(obj.class.name.demodulize)
        end
      end
    end
  end
end
