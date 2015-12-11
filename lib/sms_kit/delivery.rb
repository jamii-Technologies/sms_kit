module SmsKit
  module Delivery

    def deliver provider, options, &block
      unless klass = providers[provider.to_sym]
        raise "SMS provider #{provider} not known"
      end

      klass.deliver options, &block
    end

  end
end