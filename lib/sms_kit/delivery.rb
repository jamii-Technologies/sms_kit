module SmsKit
  module Delivery

    def deliver options, &block
      provider = options.delete :provider
      unless klass = providers[provider.to_sym]
        raise "SMS provider #{provider} not known"
      end

      klass.new(options, &block).deliver
    end

  end
end