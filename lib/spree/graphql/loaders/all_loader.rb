module Spree
  module Graphql
    module Loaders
      class AllLoader < GraphQL::Batch::Loader
        def initialize(model)
          @model = model
        end

        def perform(_ids)
          @model.all.each { |record| fulfill(record.id, record) }
        end
      end
    end
  end
end
