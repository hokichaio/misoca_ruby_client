module MisocaRubyClient
  require 'oauth2'
  class Client
    MISOCA_END_POINT='https://app.misoca.jp/api/v1/'
    MISOCA_AUTHORIZE_URI='https://app.misoca.jp/oauth2/authorize'
    MISOCA_TOKEN_URI='https://app.misoca.jp/oauth2/token'

    attr_reader :access_token

    def initialize(application_id, secret, callback_url, config_block = nil)
      @application_id = application_id
      @secret = secret
      @client = OAuth2::Client.new(@application_id, @secret, site: MISOCA_END_POINT, authorize_url: MISOCA_AUTHORIZE_URI, token_url: MISOCA_TOKEN_URI)
      @callback_url = callback_url
      @config_block = config_block
      @access_token = nil
    end

    def get_authorize_url
      return @client.auth_code.authorize_url(:redirect_uri => @callback_url, scope: 'write')
    end

    def exchange_token(code)
      @access_token = @client.auth_code.get_token(code, :redirect_uri => @callback_url)
      @config_block.call(@access_token) if @config_block
    end

    def refresh_access_token
      @access_token = @access_token.refresh!
      @config_block.call(@access_token) if @config_block
    end

    def inject_access_token(access_token, refresh_token)
      @access_token = OAuth2::AccessToken.new(@client, access_token, refresh_token: refresh_token)
    end
  end
end