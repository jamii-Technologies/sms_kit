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
  end
end
