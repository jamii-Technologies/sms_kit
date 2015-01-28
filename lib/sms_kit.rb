require 'sms_kit/version'
require 'sms_kit/utils'
require 'sms_kit/delivery'
require 'sms_kit/logging'
require 'sms_kit/railtie' if defined?(Rails)

module SmsKit
  extend Utils
  extend Delivery
  extend Logging

  class DeliveryError < StandardError; end

  USER_AGENT = "SmsKit #{VERSION}"
end
