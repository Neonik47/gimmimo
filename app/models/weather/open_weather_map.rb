# class
class Weather::OpenWeatherMap
  attr_reader :params #:lat,  :lon, :city

  API_URL = 'http://api.openweathermap.org/data/2.5/weather?'
  DEFAULT_PARAMS = ['units=metric']

  def initialize(lat, lon, city)
    Rails.logger.debug([lat,lon,city].join("/"))
    @params = DEFAULT_PARAMS
    @params.push(
      if lat.present? && lon.present?
        Rails.logger.debug("COORDS")
        "lat=#{lat}&lon=#{lon}"
      elsif city.present?
        Rails.logger.debug("CITY")
        "q=#{city}"
      else
        Rails.logger.debug("DEF")
        'q=Moscow'
      end
    )
  end

  def json
    JSON.parse(make_request('json'))
  end

  def xml
    make_request('xml')
  end

  def html
    make_request('html').html_safe
  end

  private
  
  def make_request(mode)
    @params.push("mode=#{mode}")
    uri = URI(API_URL + @params.join('&'))
    Rails.logger.debug(uri)
    Net::HTTP.get(uri)
  end
end
