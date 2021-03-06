class HomeController < ApplicationController
    require 'net/http'
    skip_before_action :verify_authenticity_token
    def index
        @data = CoronaDatum.pluck(:country, :confirmed_cases)   
        uri = URI('https://corona-virus-stats.herokuapp.com/api/v1/cases/general-stats')
        response = Net::HTTP.get(uri)  
        @stats = JSON.parse(response)
    end
  
    def receive_data
        data = request.body.read
        if data.present?
            data = JSON.parse(data)
            data['Countries'].each do |hash| CoronaDatum.find_by(country: hash['Country']).update(confirmed_cases: hash['TotalConfirmed']) end
            render :json => {:status => 200}   
        else
            render :json => {:status => 404} 
        end

    end
  
   
end
