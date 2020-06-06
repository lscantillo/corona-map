class HomeController < ApplicationController

    def index
        file = File.read('corona_data.json')
        file = JSON.parse(file)
        file['Countries'].each do |hash| CoronaDatum.create( country: hash['Country', confirmed_cases: hash['TotalConfirmed']) end
    end
  
   
end
