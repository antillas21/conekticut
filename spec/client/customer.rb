require "spec_helper"
require "json"

describe Conekticut::Client::Customer do
  before :each do
    Conekticut.configure do |c|
      c.public_key = "1tv5yJp3xnVZ7eK67m4h"
      c.ssl_cert_path = "spec/factories/ssl_cert.crt"
    end

    @client = {
      name: "Chuck Norris",
      email: "chuck@norris.ninja",
      phone: "55-5555-5555",
      cards: ["tok_8kZwafM8IcN23Nd9"],
      plan: "gold-plan"
    }
  end

  describe ".create" do
    context "with valid data" do
      it "should respond with a hash with a customer id" do
        response = Conekticut::Client::Customer.create(@client)
        response["id"].should_not be blank
      end
    end

    context "without data" do
      it "should respond with a hash with a customer id"
    end
  end
end
