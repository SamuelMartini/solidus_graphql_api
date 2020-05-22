---
title: Solidus GraphQL documentation
---

# Solidus GraphQL API

This is the GraphQL documentation for the [Solidus](https://github.com/solidusio/solidus) ecommerce platform.

## Quick Reference

- Solidus's GraphQL API endpoint is located at `/`.
- Explore the GraphQL API at *TODO* 
- Check out GraphQL's [official documentation](https://graphql.org/)


## Need help?

Join the [SolidusSlack#support-channel](http://slack.solidus.io/) and start a conversation.

## Queries

1. `completedOrders` : List of customr completed orders.
1. `countries` : List of available countries (provided by [Carmen](https://github.com/carmen-ruby/carmen)).
1. `currentOrder` : Return the current order.
1. `currentStore` : Return the current store.
1. `currentUser`: Current logged User.
1. `products`: List of available products.
1. `productBySlug`: Find a product by its slug.
1. `taxonomies`: List of available taxonomies.

Root-level queries are defined in
[`solidus_graphql_api/lib/solidus_graphql_api/types/query.rb `](https://github.com/solidusio-contrib/solidus_graphql_api/blob/master/lib/solidus_graphql_api/types/query.rb)

