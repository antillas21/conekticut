require 'spec_helper'

describe Conekticut::Client::Card do
  let(:card_attrs) { {
    number: '4242424242424242', name: 'John Doe',
    brand: 'visa', cvc: '123', month: '10', year: '2015'
   } }
  let(:card) { Conekticut::Client::Card.new(card_attrs) }

  it 'contains a brand' do
    expect(card.brand).to eq('visa')
  end

  it 'contains a display number' do
    expect(card.display_number).to eq('XXXX-XXXX-XXXX-4242')
  end

  it 'contains a credit/debit card holder name' do
    expect(card.name).to eq('John Doe')
  end

  it 'contains a CVC' do
    expect(card.cvc).to eq('123')
  end

  describe '#expiration_date' do
    it 'is a Time object' do
      expect(card.expiration_date).to be_a(Conekticut::Client::Card::ExpiryDate)
    end
  end

  it 'contains a display expiration date' do
    expect(card.display_expiration_date).to eq('10/2015')
  end
end
