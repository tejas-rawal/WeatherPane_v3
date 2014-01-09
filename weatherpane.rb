require 'sinatra'
# require 'sinatra-contrib'
require 'haml'
require 'unirest'


get '/' do  
  haml :index 
end

get '/location/:latitude/:longitude' do

  controller_lat = params[:latitude]
  controller_long = params[:longitude]

  new1 = controller_lat.gsub('x', '.')
  new2 = controller_long.gsub('x', '.')

    if new2[0] == 'n'
      new2 = new2.gsub('n','-')
    elsif new1[0] =='n'
      new1 = new1.gsub('n','-')
    end
  response = Unirest.get("https://api.forecast.io/forecast/#{ENV['FORECAST_KEY']}/#{new1},#{new2}")
  @current_condition = response.body['currently']['icon']
  @current_temp = response.body['currently']['temperature']

  place = Unirest.get("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{new1},#{new2}&sensor=true")
  
  @current_city = place.body['results'][0]['address_components'][3]['long_name']
  @current_state = place.body['results'][0]['address_components'][5]['short_name']

  @icon = "/images/#{ @current_condition }.jpg"         
end