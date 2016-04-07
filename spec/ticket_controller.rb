require 'spec_helper'

describe TicketsController do
  describe "#update_visitor" do
    let(:params){ {
                    email: "email@email.com",
                    authorization: "SaleMove Auth",
                    accept: "application/json+v1",
                    session: "SaleMove Session"} }
    
    let(:response){ "hello" }

    before do   
      allow_any_instance_of(RestClient)
        .to receive(:post)
          .and_return(response)
    end

    subject do
      described_class.new
    end

    it {expect(subject).to be "hello"}
  end
end