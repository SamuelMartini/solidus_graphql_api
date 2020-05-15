# frozen_string_literal: true

module SolidusGraphqlApi
  module Mutations
    module Promotion
      class ApplyCouponCode < BaseMutation
        null true

        argument :coupon_code, String, required: true

        field :order, Types::Order, null: true
        field :errors, [Types::UserError], null: false

        def resolve(coupon_code:)
          current_order.coupon_code = coupon_code
          handler = Spree::PromotionHandler::Coupon.new(current_order).apply

          {
            order: current_order.reload,
            errors: user_errors("order", current_order.errors)
          }
        end

        def ready?(*)
          current_ability.authorize!(:update, current_order, guest_token)
        end
      end
    end
  end
end
