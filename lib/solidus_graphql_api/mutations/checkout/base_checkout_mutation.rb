# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Checkout
      class BaseCheckoutMutation < BaseMutation
        null true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(**args)
          current_order.update(state: checkout_state)

          Spree::OrderUpdateAttributes.new(current_order, update_params(args)).apply

          {
            errors: user_errors('order', current_order.errors),
            order: current_order.reload
          }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
