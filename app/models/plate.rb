class Plate < ActiveRecord::Base

  RAW_ENDPOINT = "https://prodpci.etimspayments.com/pbw/inputAction.doh"

  has_many :citations

  def params_for_raw
    {
      :clientcode => 19,
      :requestType => "submit",
      :requestCount => 1,
      :clientAccount => 5,
      :ticketNumber => "",
      :plateNumber => number,
      :statePlate => state,
      :submit => "Search for citations"
    }
  end

  def raw_tickets
    response = HTTParty.post(RAW_ENDPOINT, 
      :body =>  params_for_raw
    )
    doc = Nokogiri.parse(response)
    raw_tickets = doc.css("table table table table tr").css("td").collect(&:text).in_groups_of(6)[1..-2]
    return [] unless raw_tickets
    raw_tickets.collect do |_, id, date, code, violation, amount|
      {
        number: id,
        date: Chronic.parse(date),
        code: code,
        violation: violation,
        amount: amount[/\d+\.\d+/]
      }
    end
  end
end
