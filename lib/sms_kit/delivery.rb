module SmsKit
  module Delivery

    def deliver options, &block
      provider = options.delete :provider
      unless mod = providers[provider.to_sym]
        raise "SMS provider #{provider} not known"
      end

      klass = mod.const_get 'Message'
      klass.new(options, &block).deliver
    end

  end
end