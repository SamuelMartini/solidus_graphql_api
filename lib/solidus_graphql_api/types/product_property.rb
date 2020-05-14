# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class ProductProperty < Base::RelayNode
      description <<-INFO
        Product properties belong to the `Spree::ProductProperty` model. They track individual attributes for a product.

        More at [Solidus Guide](https://guides.solidus.io/developers/products-and-variants/product-properties.html#product-properties)
      INFO

      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :position, Int, null: false
      field :property, Property, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
      field :value, String, null: true

      def property
        Queries::ProductProperty::PropertyQuery.new(product_property: object).call
      end
    end
  end
end
