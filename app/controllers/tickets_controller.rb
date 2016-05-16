class TicketsController < ApplicationController

  def index
    set_response_headers
    set_client   
    @tickets = @ticket_client.get_tickets(@email)
    if @tickets.kind_of? Array
      set_params
      update_visitor
    end
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
    puts "headers set"
  end

  def update_visitor
    response =  RestClient.post 'https://api.salemove.com/visitor',
                                @values,
                                @headers
    puts response
    puts "this is working"
  end

  def set_params
    @values = {
      note_update_method: 'append',
      custom_attributes: {
        ticket_1: "#{@tickets[0]["zendesk_url"]}",
        ticket_2: "#{@tickets[1]["zendesk_url"]}",
        ticket_3: "#{@tickets[2]["zendesk_url"]}",
      }
    }

    @headers = {
      authorization: "#{@auth}",
      accept: 'application/vnd.salemove.v1+json',
      x_salemove_visit_session_id: "#{@session}"
    }
  end

end