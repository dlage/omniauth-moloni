require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Moloni < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site: 'https://api.moloni.pt/v1/',
        authorize_url: 'https://api.moloni.pt/v1/authorize/',
        token_url: 'https://api.moloni.pt/v1/grant/',
        token_method: :get
      }

      # Moloni does not allow even different query params, even if with the same base URI
      def callback_url
        full_host + callback_path
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
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('users/getMe/').parsed
      end

      def email
        raw_info['email']
      end
    end
  end
end
