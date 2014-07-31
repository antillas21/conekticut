require "spec_helper"
require "json"
require "faker"

describe Conekticut::Client::Customer do
  before :each do
    Conekticut.configure do |c|
      c.public_key = "key_NYiwaF9BTknLXXes9uFcnxQ"
      c.private_key = "key_2oZcyz6PhX2hC3SW5to53Q"
      c.ssl_cert_path = "spec/factories/ssl_cert.crt"
      c.api_version = '0.3.0'
    end
  end

  describe ".create" do
    context "with valid data" do
      let(:tokenized_card) { { id: "tok_8kZwafM8IcN23Nd9" } }

      before :each do
        @client = {
          name: "James Howlett",
          email: "example@mail.guru.ninja",
          phone: "55-5555-5555",
          cards: [tokenized_card[:id]],
          plan: "gold-plan"
        }
      end

      it "should respond with a hash with a customer id", :vcr do
        response = Conekticut::Client::Customer.create(@client)
        puts "#{response}"
        response["id"].should_not eq nil
        response["id"].should start_with "cus_"
      end
    end

    context "without data" do
      it "should respond with a hash with a customer id", :vcr do
        response = Conekticut::Client::Customer.create
        response["id"].should_not eq nil
        response["id"].should start_with "cus_"
      end
    end
  end
end
