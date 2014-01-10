require 'ostruct'

module SmsKit
  module Config

    def config
      @config ||= Struct.new(:username, :password, :sender).new
    end

    def configure
      yield config
    end

    extend self

  end
end
