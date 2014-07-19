module Conekticut
  module Client
    class Card
      attr_accessor :name, :cvc, :brand, :device_fingerprint

      def initialize(attrs = {})
        @name = attrs.fetch(:name)
        @number = attrs.fetch(:number)
        @cvc = attrs.fetch(:cvc)
        @brand = attrs.fetch(:brand)
        @month = attrs.fetch(:month)
        @year = attrs.fetch(:year)
        @device_fingerprint = nil
      end

      def display_expiration_date
        [@month, @year].compact.join('/')
      end

      def display_number
        mask(@number)
      end

      def billing_address
        default_billing_address.merge(@address)
      end

      def expiration_date
        ExpiryDate.new(@month, @year)
      end

      def to_hash
        { card: {
            name: name, number: @number, brand: brand, cvc: cvc,
            exp_month: @month, exp_year: @year,
            device_fingerprint: device_fingerprint
          }
        }
      end

      def valid?
        
      end

      private

      def mask(number)
        last_digits = number[-4..-1]
        ['XXXX-XXXX-XXXX-', last_digits].join
      end

      class ExpiryDate
        def initialize(month, year)
          @month = month.to_i
          @year = year.to_i
        end
      end
    end
  end
end
