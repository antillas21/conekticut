module Conekticut
  module Client
    class Customer
      def self.create(customer = {})
        customer[:headers] = {
          user_agent: "Conekta RubyBindings/#{Base.conekta_version}",
          accept: "application/vnd.conekta-v#{ Base.api_version }+json",
          autorization: "Basic #{::Base64.encode64("#{Base.private_key}:")}",
        }

        RestClient::Request.execute method: "post", url: "https://api.conekta.io/customers", headers: headers, body: customer

#        RestClient.post "https://api.conekta.io/customers", 
#          user_agent: "Conekta/v1 RubyBindings/#{Base.conekta_version}",
#          accept: "application/vnd.conekta-v#{ Base.api_version }+json",
#          autorization: "Basic #{::Base64.encode64("#{Base.private_key}:")}",
#          headers: headers, request: customer
      end
    end
  end
end
