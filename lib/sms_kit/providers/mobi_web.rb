require 'sms_kit/provider'

module SmsKit
  class MobiWeb < Provider

    # http://api2.solutions4mobiles.com/bulksms/bulksend.go?msgtext=&originator=&password=mobiweb-pass&phone=491231234567&showDLR=1&username=mail@example.com
    HTTP_ENDPOINT = "https://api2.solutions4mobiles.com/bulksms/bulksend.go"

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
        raise DeliveryError, "#{ERROR_CODES[code.to_i]} (#{code})"
      end

      status == "OK" ? code.to_i : nil
    end

    def params
      _data = data.dup
      {
        username:   config.username,
        password:   config.password,
        originator: _data.delete(:from) || config.sender,
        phone:      _data.delete(:to),
        msgtext:    _data.delete(:text),
        showDLR:    _data.delete(:dlr) || 1,
        charset:    _data.delete(:charset) || 8
      }.merge _data
    end

  end

  register mobi_web: MobiWeb

end
