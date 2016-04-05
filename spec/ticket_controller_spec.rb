describe TicketsController do
  describe "#set_client" do
    let (:params){ {
                    email: "email@email.com",
                    authorization: "SaleMove Auth",
                    accept: "application/json+v1",
                    session: "SaleMove Session"} }

    subject do
      get :set_client, params: params
    end
    it {expect(subject[:email]).to be "email@email.co"}
  end
end