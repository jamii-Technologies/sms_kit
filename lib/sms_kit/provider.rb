require 'sms_kit/config'
require 'sms_kit/http'

module SmsKit
  class Provider
    include SmsKit::Config
    include SmsKit::HTTP

    attr_reader :data

    def self.deliver options = {}, &block
      new(options, &block).deliver
    end

    def initialize options = {}, &block
      @data = options
      yield self if block_given?
    end

    def deliver options = {}
      raise "#{self.class.name} needs to implement #deliver"
    end

    # returns the HTTP_ENDPOINT value of the message's parent module
    def _provider_api_url
      self.class.const_get 'HTTP_ENDPOINT'
    end
  end
end
