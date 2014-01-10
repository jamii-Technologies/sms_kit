module SmsKit
  module Utils

    attr_reader :providers

    def providers
      @providers ||= {}
    end

    def register map
      providers.merge! map
    end

  end
end