RSpec.shared_examples "checkout mutation authorization" do |options|
  it "responds with an unauthorized error when the current order isn't present" do
    gql_response = execute_mutation(options[:mutation_file],
                                    variables: mutation_variables,
                                    context: {
                                      current_ability: Spree::Ability.new(nil),
                                      current_order: nil
                                    })

    aggregate_failures "graphql response" do
      expect(gql_response[:data][options[:mutation_type]]).to be_nil
      expect(gql_response[:errors].first[:message]).to eq I18n.t(:"unauthorized.default")
    end
  end

  it "responds with an unauthorized error when the current order is completed" do
    order = create(:completed_order_with_totals)

    gql_response = execute_mutation(options[:mutation_file],
                                    variables: mutation_variables,
                                    context: {
                                      current_ability: Spree::Ability.new(nil),
                                      current_order: order,
                                      order_token: order.guest_token
                                    })

    aggregate_failures "graphql response" do
      expect(gql_response[:data][options[:mutation_type]]).to be_nil
      expect(gql_response[:errors].first[:message]).to eq I18n.t(:"unauthorized.default")
    end
  end

  it "responds with an unauthorized error when the current ability is unauthorized" do
    gql_response = execute_mutation(options[:mutation_file],
                                    variables: mutation_variables,
                                    context: {
                                      current_ability: Spree::Ability.new(nil),
                                      current_order: create(:order),
                                      order_token: "token_unauthorized_for_the_current_order"
                                    })

    aggregate_failures "graphql response" do
      expect(gql_response[:data][options[:mutation_type]]).to be_nil
      expect(gql_response[:errors].first[:message]).to eq I18n.t(:"unauthorized.default")
    end
  end
end
