require 'faraday'

module SmsKit
  module HTTP

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
      @conn ||= Faraday.new "#{uri.scheme}://#{uri.host}", ssl: { verify: false } do |f|
        f.headers[:user_agent] = USER_AGENT
        f.response :logger, SmsKit.logger
        f.adapter Faraday.default_adapter
        yield f if block_given?
      end
    end

  end
end