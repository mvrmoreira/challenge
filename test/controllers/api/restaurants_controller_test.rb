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

  test "filter restaurants for available for reservation today" do
    # hoje esse restaurante aceita no maximo 10 pessoas
    # porem já exite 3 reservas de 2 pessoas criadas
    restaurant = Restaurant.first
    now = DateTime.now

    3.times{ create(:reservation, restaurant: restaurant, event_time: now, seats: 2) }

    get "/api/restaurants", params: { date: now, seats: 2 }
    assert_response :success
    assert_equal(5, JSON.parse(@response.body).count)

    get "/api/restaurants", params: { date: now, seats: 4 }
    assert_response :success
    assert_equal(5, JSON.parse(@response.body).count)

    get "/api/restaurants", params: { date: now, seats: 6 }
    assert_response :success
    assert_equal(4, JSON.parse(@response.body).count)
  end

  test "filter restaurants for available for reservation tomorow" do
    # amanhã esse restaurante aceita no maximo 4 pessoas
    # porem já exite uma reservas de 2 pessoas criadas
    restaurant = Restaurant.first
    tomorrow =  DateTime.tomorrow
    create(:reservation, restaurant: restaurant, event_time: tomorrow, seats: 2)

    get "/api/restaurants", params: { date: tomorrow, seats: 2 }
    assert_response :success
    assert_equal(5, JSON.parse(@response.body).count)

    get "/api/restaurants", params: { date: tomorrow, seats: 4 }
    assert_response :success
    assert_equal(4, JSON.parse(@response.body).count)

    get "/api/restaurants", params: { date: tomorrow, seats: 6 }
    assert_response :success
    assert_equal(4, JSON.parse(@response.body).count)
  end
end
