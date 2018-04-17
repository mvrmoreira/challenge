class Api::RestaurantsController < ApplicationController
  def index

    if params[:culinaryId]
      @results = Restaurant.by_culinary(params[:culinaryId])
    elsif params[:date] && params[:seats]
      date = Date.parse(params[:date])
      @results = Restaurant.available(date, params[:seats])
    else
      @results = Restaurant.all
    end

    render json: @results
  end

  private

    def restaurant_params
      params.permit(:culinaryId, :date, :seats)
    end
end
