require 'sms_kit/version'
require 'sms_kit/utils'
require 'sms_kit/delivery'

module SmsKit
  extend Utils
  extend Delivery

  USER_AGENT = "SmsKit #{VERSION}"
end

require 'sms_kit/providers'
