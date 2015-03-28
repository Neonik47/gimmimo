require 'json'

class Services::WeatherController < ApplicationController
  before_filter :set_params

  def index
    Rails.logger.debug(params)
    respond_to do |format|
      format.html { render html: current_weather.html } #text: 'В разработке' }
      format.json { render json: current_weather.json }
      format.xml { render xml: current_weather.xml }
    end
    
  end

  private

  def set_params
  end

  def current_weather
    Weather::OpenWeatherMap.new(params[:lat], params[:lon], params[:city])
  end
end
