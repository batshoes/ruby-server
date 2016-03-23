require 'rest_client'
class TicketsController < ApplicationController

  def index
    set_response_headers
    set_client
    @tickets = @ticket_client.get_tickets(@email)
    set_params
    update_visitor
  end

private

  def set_client
    @ticket_client = ::Baublebar::GetZenDeskTickets.new

    @email = params[:email]
    @auth = params[:Authorization]
    @accept = params[:Accept]
    @session = params[:Session]
  end

  def set_response_headers
    response.headers['Access-Control-Allow-Origin'] = "http://www.salemove.com"
    response.headers['Access-Control-Allow-Credentials'] = "true"
  end

  def update_visitor
    response = RestClient.post 'https://api.salemove.com/visitor', @values, @headers
    puts response
  end

  def set_params
    @values = {
      'note_update_method': 'append',
      'custom_attributes': {
        "Ticket 1": "#{@tickets[0]["zendesk_url"]}",
        "Ticket 2": "#{@tickets[1]["zendesk_url"]}",
        "Ticket 3": "#{@tickets[2]["zendesk_url"]}",
      }
    }

    @headers = {
      authorization: "#{@auth}",
      accept: 'application/vnd.salemove.v1+json',
      x_salemove_visit_session_id: "#{@session}"
    }
  end

end