# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class OptionValue < Base::RelayNode
      description <<-INFO
        The option type requires at least one associated `Spree::OptionValue` to be used.
        For example, your "Color" option type might have ten or one hundred option values.

        More at [Solidus Guide](https://guides.solidus.io/developers/products-and-variants/variants.html#option-types)
      INFO

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :name, String, null: false
      field :position, String, null: false
      field :presentation, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
  end
end
