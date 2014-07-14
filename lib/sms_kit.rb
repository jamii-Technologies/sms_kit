require 'sms_kit/version'
require 'sms_kit/utils'
require 'sms_kit/delivery'
require 'sms_kit/logging'

module SmsKit
  extend Utils
  extend Delivery
  extend Logging

  USER_AGENT = "SmsKit #{VERSION}"
end
