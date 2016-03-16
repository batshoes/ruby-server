class HomeController < ApplicationController
  def index
    response.headers['Access-Control-Allow-Origin'] = "salemove.com"
    response.headers['Access-Control-Allow-Credentials'] = "true"
    
    # @tickets = BaubleBar::GetZenDeskTickets.new(email_params)
    
  end


  private
    def email_params
      
    end
end
