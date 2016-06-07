module SmsKit
  module Utils

    def providers
      @providers ||= {}
    end

    def register map
      providers.merge! map
    end

  end
end