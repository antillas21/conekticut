require 'spec_helper'

describe Conekticut::Client::Card do
  let(:card_attrs) { {
    number: '4242424242424242', first_name: 'John', last_name: 'Doe',
    brand: 'visa', cvc: '123', month: '10', year: '2015'
   } }
  let(:card) { Conekticut::Client::Card.new(card_attrs) }

  it 'contains a brand' do
    expect(card.brand).to eq('visa')
  end

  it 'contains a credit/debit card number' do
    expect(card.number).to eq('4242424242424242')
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

  describe '#billing_address' do
    it 'contains an empty address hash when not provided' do
      expect(card.billing_address).to eq({street1: nil, street2: nil, city: nil, state: nil, zip: nil, country: nil})
    end

    it 'contains all values of passed in the :address key' do
      with_address = card_attrs.merge(address: {
        street1: '123 Main St.', city: 'Smallville', state: 'Kansas',
        zip: '12345', country: 'United States'
      })

      card = Conekticut::Client::Card.new(with_address)
      expect(card.billing_address).to eq({
        street1: '123 Main St.', street2: nil, city: 'Smallville', state: 'Kansas',
        zip: '12345', country: 'United States'
      })
    end
  end
end
