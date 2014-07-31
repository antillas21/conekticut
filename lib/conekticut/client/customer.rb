module Conekticut
  module Client
    class Customer
      def self.create(customer = {})
        headers = {
          "accept" => "application/vnd.conekta-v#{ Base.api_version }+json",
          "authorization" => "Basic #{::Base64.encode64("#{Base.public_key}:")}",
        }

        response = HTTParty.post(
          'https://api.conekta.io/customers', headers: headers, body: customer
        )
      end
    end
  end
end
