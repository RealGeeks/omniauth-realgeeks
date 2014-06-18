require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class RealGeeks < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://login.realgeeks.com/oauth',
        :authorize_url => 'https://login.realgeeks.com/oauth/authorize',
        :token_url => 'https://login.realgeeks.com/oauth/token'
      }

      def request_phase
        super
      end

      def authorize_params
        super.tap do |params|
          %w[scope client_options].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      def callback_phase
        super
      end

      uid { raw_info['id'].to_s }

      info do
        {
          'name' => raw_info['first_name'] + ' ' + raw_info['last_name'],
          'email' => email,
          'first_name' => raw_info['first_name'],
          'last_name' => raw_info['last_name'],
        }
      end

      extra do
        {
          'active_status' => raw_info['active_status'],
          'is_owner' => raw_info['is_owner'],
          'super_user' => raw_info['super_user'],
        }
      end

      def raw_info
        access_token.options[:mode] = :header
        @raw_info ||= access_token.get('user').parsed
      end

      def email
         raw_info['email']
      end
    end
  end
end

OmniAuth.config.add_camelization 'realgeeks', 'RealGeeks'
