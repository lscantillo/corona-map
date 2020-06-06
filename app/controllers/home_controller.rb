class HomeController < ApplicationController

    def index
        @data = CoronaDatum.pluck(:country, :confirmed_cases)
    end
  
    def receive_data
          data = request.body.receive_data
          JSON.parse(data)
          data['Countries'].each do |hash| CoronaDatum.find_by(country: hash['Country']).update(confirmed_cases: hash['TotalConfirmed']) end
              
    end
  
   
end
