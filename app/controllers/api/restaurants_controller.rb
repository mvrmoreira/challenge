class Api::RestaurantsController < ApplicationController
  def index
    @results = Restaurant.all

    if params[:culinaryId]
      @results = filter(@results)
    end

    render json: @results
  end

  def filter(restaurants)
      restaurants.select do |restaurant|
        restaurant.culinary_ids.include?(params[:culinaryId].to_i)
      end
  end
end
