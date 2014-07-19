module Conekticut
  module Client
    class Tokenizer
      class InvalidObjectTypeError < StandardError; end

      VALID_CHARS = 'abcdefghijklmnopqrstuvwxyz0123456789'

      def self.tokenize(card)
        fail(InvalidObjectTypeError, 'Invalid argument. Argument must be a Conekticut::Client::Card object.') unless card.is_a?(Card)


        if card.valid?
          # append :device_fingerprint
          card.device_fingerprint = generate_fingerprint

          fail StandardError, "Please, verify your api key." \
            unless RequestHandler.has_valid_api_key?

          conekta_bindings = {"agent"=>"Conekta JavascriptBindings/0.3.0"}
          headers = {
            'Accept' => "application/vnd.conekta-v#{Base.api_version}+json",
            'Authorization' => "Basic #{Base64.encode64(Base.public_key)}",
            'Conekta-Client-User-Agent' => conekta_bindings.to_json
          }

          response = HTTParty.post(
            'https://api.conekta.io/tokens', headers: headers,
            body: card.to_hash
          )
        end
      end

      def self.generate_fingerprint
        SecureRandom.hex(15)
      end
    end
  end
end
