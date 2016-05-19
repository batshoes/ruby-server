class TicketsController < ApplicationController

  before_filter :zendesk
  
  def zendesk
    set_response_headers
    set_client   
    @tickets = @ticket_client.get_tickets(@email)
    if @tickets.kind_of? Array
      set_params
      update_visitor
    else
      response.status = 204
      return response
    end
    rescue NoMethodError
      p "Accessing the server directly will not update the user."
  end
    
private

  def set_client
    @ticket_client = ::Baublebar::GetZenDeskTickets.new

    @email = params[:email]
    @auth = params[:authorization]
    @accept = params[:accept]
    @session = params[:session]
  end

  def set_response_headers
    response.headers['Access-Control-Allow-Origin'] = "http://www.salemove.com"
    response.headers['Access-Control-Allow-Credentials'] = true
  end

  def update_visitor
    response =  RestClient.post 'https://api.salemove.com/visitor', @values, @headers
    puts response
  end

  def set_params
    ticket_attributes = {}
    ticket_number = 1
    @tickets.each do |t|
      
      ticket_attributes["Ticket: #{ticket_number}"] = t["status"] + ": " + t["zendesk_url"]

      ticket_number += 1
    end

    @values = {
      note_update_method: 'append',
      custom_attributes: ticket_attributes
    }

    @headers = {
      authorization: "#{@auth}",
      accept: 'application/vnd.salemove.v1+json',
      x_salemove_visit_session_id: "#{@session}"
    }
  end

end