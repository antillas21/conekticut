require "spec_helper"
require "json"
require "faker"

describe Conekticut::Client::Customer do
  before :each do
    Conekticut.configure do |c|
      c.public_key = "key_NYiwaF9BTknLXXes9uFcnxQ"
      c.private_key = "key_2oZcyz6PhX2hC3SW5to53Q"
      c.ssl_cert_path = "spec/factories/ssl_cert.crt"
      c.api_version = '"0.3.0"'
    end
  end

  describe ".create" do
    context "with valid data" do
      let(:customer) { 
        { name: 'James Howlett',  email: 'howlett@example.com', phone: '55-5555-5555' }
      }


      it "should respond with a hash with a customer id", :vcr => { :record => :new_episodes } do
        response = Conekticut::Client::Customer.create(customer)
        puts response
        response["id"].should_not be_nil
        response["id"].should start_with "cus_"
      end
    end

    context "without data" do
      it "should respond with a hash with a customer id", :vcr => { :record => :new_episodes } do
        response = Conekticut::Client::Customer.create
        response["id"].should_not be_nil
        response["id"].should start_with "cus_"
      end
    end
  end
end
