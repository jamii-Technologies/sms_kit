require 'sms_kit/provider'

module SmsKit
  class MobiWeb < Provider

    HTTP_ENDPOINT = "http://217.118.27.5/bulksms/bulksend.go"

    ERROR_CODES = {
      100 => 'Temporary Internal Server Error. Try again later',
      101 => 'Authentication Error',
      102 => 'No credits available',
      103 => 'MSIDSN (phone parameter) is invalid or prefix is not supported',
      104 => 'Tariff Error',
      105 => 'You are not allowed to send to that destination/country',
      106 => 'Not Valid Route number or you are not allowed to use this route',
      107 => 'No proper Authentication (IP restriction is activated)',
      108 => 'You have no permission to send messages through HTTP API',
      109 => 'Not Valid Originator',
      110 => 'You are not allowed to send (Routing not available) or Reseller is trying to send while not allowed',
      111 => 'Invalid Expiration date or Expiration Date is less than 30 minutes than the date of SMS submission',
      999 => 'Invalid HTTP request'
    }

    def deliver
      response = get params
      status   = response.body[/([a-z]+)(\d+)?/i, 1]
      code     = response.body[/([a-z]+)(\d+)?/i, 2]

      if 'ERROR' == status
        @error_code = code.to_i
        @error_message = ERROR_CODES[code.to_i]
      end

      status == "OK" ? code.to_i : nil
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
