# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Taxon < Base::RelayNode
      description <<-INFO
        Taxonomies and taxons provide a robust way to classify and categorize products.
        They belong to the `Spree::Taxonomy` and `Spree:Taxon` models.

        More at [Solidus Guide](https://guides.solidus.io/developers/products-and-variants/taxonomies-and-taxons.html#taxonomies-and-taxons)
      INFO

      field :children, Taxon.connection_type, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :description, String, null: true
      field :icon_url, String, null: true
      field :meta_description, String, null: true
      field :meta_keywords, String, null: true
      field :meta_title, String, null: true
      field :name, String, null: false
      field :parent_taxon, Types::Taxon, null: true
      field :permalink, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def icon_url
        object.icon.url
      end

      def parent_taxon
        Queries::Taxon::ParentTaxonQuery.new(taxon: object).call
      end

      def children
        Queries::Taxon::ChildrenQuery.new(taxon: object).call
      end
    end
  end
end
