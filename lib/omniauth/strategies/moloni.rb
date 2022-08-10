require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Moloni < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://api.moloni.pt/v1/',
        :authorize_url => 'https://api.moloni.pt/v1/authorize/',
        :token_url => 'https://api.moloni.pt/v1/grant/'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      uid { raw_info['user_id'].to_s }

      info do
        {
          'name' => raw_info['name'],
          'email' => raw_info['email'],
          'cellphone' => raw_info['cellphone'],
          'language_id' => raw_info['language_id'],
          'language' => raw_info['language'],
          'registered_since' => raw_info['registered_since'],
          'last_login' => raw_info['last_login'],
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('users/getMe/').parsed
      end

      def email
        raw_info['email']
      end

      def scope
        access_token['scope']
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
