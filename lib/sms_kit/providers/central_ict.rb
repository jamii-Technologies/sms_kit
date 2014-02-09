require 'sms_kit/provider'

module SmsKit
  class CentralICT < Provider

    HTTP_ENDPOINT = 'http://api.de.centralict.net/controller/cgi/'

    def deliver
      response = get params
      status = response.body.split('=').last
      status.to_i == 1
    end

    def params
      {
        type:    'SMS',
        src:     data[:from] || config.sender,
        dst:     data[:to],
        body:    data[:text],
        uid:     data[:uid] || '',
        pin:     data[:pin] || '',
        subject: data[:subject] || '',
        call:    data[:call] || 'message_sender'
      }
    end

    def get payload
      connection.basic_auth config.username, config.password
      super
    end

  end

  register central_ict: CentralICT

end
