module Conekticut
  module Client
    class Customer
      def self.create(customer = {})
        headers = {
          "Accept" => "application/vnd.conekta-v#{ Base.api_version }+json",
          "Authorization" => "Basic #{::Base64.encode64(Base.private_key)}"
        }

        response = HTTParty.post(
          'https://api.conekta.io/customers', headers: headers, body: customer
        )
      end
    end
  end
end
