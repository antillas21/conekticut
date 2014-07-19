require "base64"
require "rest_client"
require "multi_json"
require "conekticut/client/configuration"

module Conekticut
  module Client
    class Tokenizer
      class InvalidObjectTypeError < StandardError; end

      VALID_CHARS = 'abcdefghijklmnopqrstuvwxyz0123456789'

      def self.tokenize(card)
        fail(InvalidObjectTypeError, 'Invalid argument. Argument must be a Conekticut::Client::Card object.') unless card.is_a?(Card)


        if card.valid?
          # append :device_fingerprint
          card.device_fingerprint = generate_session_id

          # perform tokenizing
          raise StandardError, "Please, verify your api key." \
            unless RequestHandler.has_valid_api_key?

          request_options = {
            :headers => {
              :user_agent => "Conekta JavascriptBindings/0.3.0",
              :authorization => "Basic #{::Base64.encode64("#{Base.private_key}:")}",
              :accept=>"application/vnd.conekta-v#{ Base.api_version }+json"
            }, :method => :post, :open_timeout => 30,
            :payload => card.to_hash, :url => 'https://api.conekta.io/tokens.json',
            :timeout => 80
          }
          binding.pry

          # if RequestHandler.require_ssl?
          #   request_options.update(:verify_ssl => OpenSSL::SSL::VERIFY_PEER,
          #     :ssl_ca_file => Base.ssl_cert_path)
          # end

          # unless payment_info.respond_to? :to_hash
          #   raise StandardError, "Expected: Hash, got: #{params.class}"
          # end

          full_request_url = 'https://api.conekta.io/tokens.json'

          begin
            response = ::RestClient::Request.execute(request_options)
          rescue RestClient::UnprocessableEntity => e
            return { "status" => 422, "message" => e.message }
          end

          # ::MultiJson.load response
        end
      end

      def self.generate_session_id
        str = ''
        30.times do
          str << VALID_CHARS[rand(0..35)]
        end
        str
      end
    end
  end
end
