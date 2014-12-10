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

    class Store < Hash
      def method_missing meth, *args
        unless respond_to? meth
          if key = meth.to_s[/(.*)=$/, 1]
            self[key.to_sym] = args.first
          else
            self[meth.to_sym]
          end
        else
          super
        end
      end
    end

    module ClassMethods

      def config
        @config ||= Store.new
      end

      def configure
        yield config
      end

    end

  end
end
