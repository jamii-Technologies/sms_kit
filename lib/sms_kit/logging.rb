module SmsKit
  module Logging

    def logger
      @logger ||= begin
        require 'logger'
        Logger.new(STDOUT).tap do |l|
          l.formatter ||= Logger::Formatter.new
          l.formatter.extend Formatter
        end
      end
    end

    def logger= l
      @logger = l.tap do |l|
        l.formatter ||= Logger::Formatter.new
        l.formatter.extend Formatter
      end
    end

    module Formatter
      def call severity, datetime, progname, msg
        '[SmsKit] ' + super(severity, datetime, progname, msg)
      end
    end

  end
end
