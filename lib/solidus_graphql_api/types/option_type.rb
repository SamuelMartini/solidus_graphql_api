# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class OptionType < Base::RelayNode
      graphql_name 'OptionType'

      description <<-INFO
        The `Spree::OptionType` model is used to define variants for a product.

        More at [Solidus Guide](https://guides.solidus.io/developers/products-and-variants/variants.html#option-types)
      INFO

      field :name, String, null: false
      field :presentation, String, null: false
      field :position, Int, null: false
      field :option_values, OptionValue.connection_type, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def option_values
        Queries::OptionType::OptionValuesQuery.new(option_type: object).call
      end
    end
  end
end
