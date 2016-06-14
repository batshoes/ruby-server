require 'spec_helper'

describe TicketsController do
  describe "GET index" do
    context "when email is attached to tickets" do
      let(:params){ {
                    email: "email@email.com",
                    authorization: "SaleMove Auth",
                    accept: "application/json+v1",
                    session: "SaleMove Session"} }
      let(:response){

      }
      it {expect(response).to render_template("index")}
    end
  end
end