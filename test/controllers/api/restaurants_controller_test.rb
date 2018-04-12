require 'test_helper'

class Api::RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  setup do
    5.times{create(:restaurant)}
  end

  test "list all restaurants" do
    get "/api/restaurants"

    assert_response :success
    assert_equal(Restaurant.count, JSON.parse(@response.body).count)
  end
end
