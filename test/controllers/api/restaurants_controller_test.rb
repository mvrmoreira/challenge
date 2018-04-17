require 'test_helper'

class Api::RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  setup do
    # criantdo para todos os testes 5 restaurantes
    # em 2 culinarias
    create(:culinary, name:"Italiana", restaurant_count: 3)
    create(:culinary, name:"Japonesa", restaurant_count: 2)
  end

  test "filter restaurants for available for reservation today" do
    # hoje esse restaurante aceita no maximo 10 pessoas
    # porem já exite 3 reservas de 2 pessoas criadas cada
    now = DateTime.now

    Restaurant.all.each do |restaurant|
      create(:inventory, restaurant: restaurant, week_day: now.wday, seats: 10)
    end

    first_restaurant = Restaurant.first

    3.times{ create(:reservation, restaurant: first_restaurant, event_time: now, seats: 2) }

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
    # porem já exite uma reservas de 2 pessoas criadas cada
    
    tomorrow =  DateTime.tomorrow

    first_restaurant = Restaurant.first

    create(:inventory, restaurant: first_restaurant, week_day: tomorrow.wday, seats: 4)
    create(:reservation, restaurant: first_restaurant, event_time: tomorrow, seats: 2)

    Restaurant.all.where("id != ?", first_restaurant.id).each do |restaurant|
      create(:inventory, restaurant: restaurant, week_day: tomorrow.wday, seats: 10)
    end

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
