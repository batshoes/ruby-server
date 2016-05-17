require 'spec_helper'

describe TicketsController do
  describe ".index" do
    let(:params){ {
                    email: "email@email.com",
                    authorization: "SaleMove Auth",
                    accept: "application/json+v1",
                    session: "SaleMove Session"} }

    subject do
      described_class.new
    end

    context "when email is attached to tickets" do
      it {expect(subject.status).to eq 200}
    end
  end
end