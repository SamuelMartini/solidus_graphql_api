# frozen_string_literal: true

module SolidusGraphqlApi
  module Types
    class Taxonomy < Base::RelayNode
      description <<-INFO
        Taxonomies and taxons provide a robust way to classify and categorize products.
        They belong to the `Spree::Taxonomy` and `Spree:Taxon` models.

        More at [Solidus Guide](https://guides.solidus.io/developers/products-and-variants/taxonomies-and-taxons.html#taxonomies-and-taxons)
      INFO

      field :name, String, null: false
      field :root_taxon, Taxon, null: true
      field :taxons, Taxon.connection_type, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: true

      def root_taxon
        Queries::Taxonomy::RootTaxonQuery.new(taxonomy: object).call
      end

      def taxons
        Queries::Taxonomy::TaxonsQuery.new(taxonomy: object).call
      end
    end
  end
end
