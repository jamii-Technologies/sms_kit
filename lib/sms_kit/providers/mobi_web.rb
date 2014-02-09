require 'sms_kit/provider'

module SmsKit
  class MobiWeb < Provider

    HTTP_ENDPOINT = "http://217.118.27.5/bulksms/bulksend.go"

    def deliver
      response = get params
      status   = response.body[/([a-z]+)(\d+)?/i, 1]
      sms_id   = response.body[/([a-z]+)(\d+)?/i, 2]

      status == "OK" ? sms_id.to_i : nil
    end

    def params
      {
        username:   config.username,
        password:   config.password,
        originator: data[:from] || config.sender,
        phone:      data[:to],
        msgtext:    data[:text],
        showDLR:    1
      }
    end

  end

  register mobi_web: MobiWeb

end
