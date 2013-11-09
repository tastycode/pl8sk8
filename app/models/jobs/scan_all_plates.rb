require "httparty"
module Jobs
  class ScanAllPlates
    @queue = 'scan_all_plates'
    def self.perform
      @client = Twilio::REST::Client.new "AC82d93cbf2ba47eeb56ad75d536506cef", "63e48ea15055927245f3e20f791312eb"
      Plate.all.each do |plate|
        new_tickets = []
        plate.raw_tickets.each do |raw_ticket|
          unless Citation.find_by_number(raw_ticket[:number])
            c = Citation.new(raw_ticket)
            c.plate = plate
            c.save
            new_tickets << c
          end
        end
        if new_tickets.any?
          puts ["texting ", plate.phone, "summary for", new_tickets].inspect
          @client.account.sms.messages.create(
            :from => '+14157671505',
            :to => "+1#{plate.phone}",
            :body => "You have #{new_tickets.size} tickets - totaling #{new_tickets.collect(&:amount).inject(&:+)} - http://www.carport.io/plates/#{plate.id}"
          )
        end
      end
    end
  end
end
