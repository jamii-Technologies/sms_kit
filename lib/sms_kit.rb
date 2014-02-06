require 'sms_kit/version'
require 'sms_kit/utils'
require 'sms_kit/delivery'

module SmsKit
  extend Utils
  extend Delivery
end

require 'sms_kit/providers'
