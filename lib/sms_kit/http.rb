require 'sms_kit/version'
require 'faraday'

module SmsKit
  module HTTP
    USER_AGENT = "SmsKit/#{VERSION} (https://rubygems.org/gems/sms_kit)"

    def uri
      @uri ||= URI.parse self.class.const_get 'HTTP_ENDPOINT'
    end

    def post data
      connection.post uri.path, data
    end

    def get data
      connection.get uri.path, data
    end

    def connection
      if 'https' != uri.scheme
        warn "[SmsKit] Provider '#{self.class.name}' is using an unencrypted connection: #{uri}"
      end

      @conn ||= Faraday.new "#{uri.scheme}://#{uri.host}" do |f|
        f.headers[:user_agent] = USER_AGENT
        f.response :logger, SmsKit.logger
        f.adapter Faraday.default_adapter
        yield f if block_given?
      end
    end

  end
end