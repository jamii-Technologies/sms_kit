module SmsKit
  module Message
    attr_reader :data

    def initialize options = {}, &block
      @data = options
      yield self if block_given?
    end

    def uri
      @uri ||= URI.parse _provider_api_url
    end

    def post data
      connection.post uri.path, data
    end

    def get data
      connection.get uri.path, data
    end

    def connection
      @conn ||= Faraday.new "#{uri.scheme}://#{uri.host}" do |f|
        f.headers[:user_agent] = "SmsKit #{VERSION}"
      end
    end

    # returns the API_URL value of the message's parent module
    def _provider_api_url
      ns = self.class.name.split '::'
      ns.pop; ns << 'API_URL'
      ns.inject(Object) { |mod, class_name| mod.const_get class_name }
    end
  end
end
