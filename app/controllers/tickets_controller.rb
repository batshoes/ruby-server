class TicketsController < ApplicationController
  def index
    response.headers['Access-Control-Allow-Origin'] = "http://www.salemove.com"
    response.headers['Access-Control-Allow-Credentials'] = "true"
    @email = params[:email]
    @auth = params[:Authorization]
    @accept = params[:Accept]
    @session = params[:Session]
    
  end
end