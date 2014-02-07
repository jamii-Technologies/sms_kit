require 'sms_kit/providers/mobi_web'
require 'sms_kit/providers/mobimex'
require 'sms_kit/providers/central_ict'

SmsKit.register mobi_web: SmsKit::MobiWeb
SmsKit.register mobimex: SmsKit::Mobimex
SmsKit.register central_ict: SmsKit::CentralICT
