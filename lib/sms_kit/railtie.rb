module SmsKit
  class Railties < ::Rails::Railtie
    initializer 'sms_kit.logger' do
      SmsKit.logger = Logger.new Rails.root.join('log/sms_kit.log')
    end
  end
end