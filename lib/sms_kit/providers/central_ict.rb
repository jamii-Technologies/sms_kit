require 'sms_kit/provider'

module SmsKit
  class CentralICT < Provider

    HTTP_ENDPOINT = 'http://api.de.centralict.net/controller/cgi/'

    def deliver
      response        = get params
      parsed_response = parse response.body
      status          = parsed_response['sent']

      if 1 != status.to_i
        raise DeliveryError, "Delivery failed (#{status})"
      else
        true
      end
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

    def parse string
      Hash[string.scan /(\w+)=(.*)/]
    end

  end

  register central_ict: CentralICT

end
