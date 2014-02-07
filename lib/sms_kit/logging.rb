module SmsKit
  module Logging

    attr_accessor :logger

    def logger
      @logger ||= begin
        require 'logger'
        Logger.new STDOUT
      end
    end

  end
end
