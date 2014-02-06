require 'ostruct'

module SmsKit
  module Config

    def self.included base
      base.extend ClassMethods

      base.class_eval do
        def config
          self.class.config
        end
      end
    end

    module ClassMethods

      def config
        @config ||= Struct.new(:username, :password, :sender).new
      end

      def configure
        yield config
      end

    end

  end
end
