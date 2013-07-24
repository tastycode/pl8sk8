require 'rubygems'
require 'httparty'

module Jobs
  class ScanPlate
    def self.perform(plate, state)
      response = HTTParty.post("https://prodpci.etmispayments.com/pbw/inputAction.doh", 
        :body =>  {
          :clientcode => 19,
          :requestType => "submit",
          :requestCount => 1,
          :clientAccount => 5,
          :ticketNumber => "",
          :plateNumber => plate,
          :statePlate => state,
          :submit => "Search for citations"
        }
      )
     ap response
    end
  end
end
