require 'sms_kit/config'
require 'sms_kit/message'
require 'faraday'

module SmsKit
  module MobiWeb
    extend SmsKit::Config

    API_URL = "http://217.118.27.5/bulksms/bulksend.go"

    class Message
      include SmsKit::Message

      def deliver
        response = get params
        status   = response.body[/([a-z]+)(\d+)?/i, 1]
        sms_id   = response.body[/([a-z]+)(\d+)?/i, 2]

        status == "OK" ? sms_id : nil
      end

      def params
        {
          username:   MobiWeb.config.username,
          password:   MobiWeb.config.password,
          originator: data[:from] || MobiWeb.config.sender,
          phone:      data[:to],
          msgtext:    data[:text],
          showDLR:    1
        }
      end
    end
  end
end
