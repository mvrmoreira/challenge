class Api::RestaurantsController < ApplicationController
  def index

    if params[:culinaryId]
      @results = Restaurant.by_culinary(params[:culinaryId])
    else
      @results = Restaurant.all
    end

    render json: @results
  end

  private

    def restaurant_params
      params.permit(:culinaryId)
    end
end
