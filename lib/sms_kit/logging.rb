require 'logger'

module SmsKit
  module Logging

    attr_writer :logger

    def logger
      @logger ||= begin
        require 'logger'
        Logger.new(STDOUT).tap do |l|
          if l.respond_to? :formatter=
            l.formatter ||= Logger::Formatter.new
            l.formatter.extend Formatter
          end
        end
      end
    end

    module Formatter
      def call severity, datetime, progname, msg
        '[SmsKit] ' + super(severity, datetime, progname, msg)
      end
    end

  end
end
