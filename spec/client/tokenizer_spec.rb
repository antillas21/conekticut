require 'spec_helper'

describe Conekticut::Client::Tokenizer do
  before :each do
    Conekticut.configure do |c|
      c.public_key = "1tv5yJp3xnVZ7eK67m4h"
      c.private_key = "1tv5yJp3xnVZ7eK67m4h"
      c.ssl_cert_path = "spec/factories/ssl_cert.crt"
      c.api_version = '0.3.0'
      @payments_status_list = ["paid", "pending_payment"]
    end
  end

  describe '.generate_session_id' do
    it 'returns a 30 characters random string' do
      session_id = Conekticut::Client::Tokenizer.generate_session_id
      expect(session_id.length).to eq(30)
    end
  end

  describe '.tokenize_card' do
    let(:card_attrs) { {
      number: '4242424242424242', first_name: 'John', last_name: 'Doe',
      brand: 'visa', cvc: '123', month: '10', year: '2015'
     } }
    let(:card) { Conekticut::Client::Card.new(card_attrs) }

    it 'must receive a card data as argument' do
      expect { Conekticut::Client::Tokenizer.tokenize }.to raise_error
    end

    it 'card argument must be a Conekticut::Client::Card object' do
      card = { foo: 'bar', baz: 'del' }
      expect { Conekticut::Client::Tokenizer.tokenize(card) }.to raise_error
    end

    it 'does not raise error if receives a Conekticut::Client::Card object' do
      expect { Conekticut::Client::Tokenizer.tokenize(card) }.to_not raise_error
    end

    it 'validates card before performing any action' do
      allow(card).to receive(:valid?).and_return(true)

      expect(card).to receive(:valid?)
      Conekticut::Client::Tokenizer.tokenize(card)
    end

    context 'with valid Conekticut::Client::Card object' do
      it 'appends a :device_fingerprint value (session_id)' do
        allow(card).to receive(:valid?).and_return(true)
        Conekticut::Client::Tokenizer.tokenize(card)
        expect(card.device_fingerprint).to_not be_nil 
      end

      it 'submits card info to Conekta servers' do
        allow(card).to receive(:valid?).and_return(true)
        expect(::RestClient::Request).to receive(:execute).with(any_args())
        Conekticut::Client::Tokenizer.tokenize(card)
      end

      it 'returns a token object if successful'
    end

    context 'with invalid Conekticut::Client::Card object' do
      it 'does nothing'
    end
  end
end
