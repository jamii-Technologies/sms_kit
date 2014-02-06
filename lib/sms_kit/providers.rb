require 'sms_kit/providers/mobi_web'
require 'sms_kit/providers/mobimex'

SmsKit.register mobi_web: SmsKit::MobiWeb
SmsKit.register mobimex: SmsKit::Mobimex
