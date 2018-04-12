require 'test_helper'

class Api::RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  setup do
    create(:culinary, name:"Italiana", restaurant_count: 3)
    create(:culinary, name:"Japonesa", restaurant_count: 2)
  end

  test "list all restaurants" do
    get "/api/restaurants"

    assert_response :success
    assert_equal(5, JSON.parse(@response.body).count)
  end

  test "filter japanese restaurants" do
    culinary = Culinary.find_by_name "Japonesa"

    get "/api/restaurants", params:{culinaryId: culinary.id}

    assert_response :success
    assert_equal(2, JSON.parse(@response.body).count)
  end
end
