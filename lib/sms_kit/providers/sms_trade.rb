require 'sms_kit/provider'
require 'uri'

module SmsKit
  class SmsTrade < Provider

    ROUTE_BASIC  = 'Basic'.freeze
    ROUTE_GOLD   = 'gold'.freeze
    ROUTE_DIRECT = 'direct'.freeze

    HTTP_ENDPOINT = "https://gateway.smstrade.de/"

    ERROR_CODES = {
      10  => 'Receiver number not valid',
      20  => 'Sender number not valid',
      30  => 'Message text not valid',
      31  => 'Message type not valid',
      40  => 'SMS route not valid',
      50  => 'Identification failed',
      60  => 'Not enough balance in account',
      70  => 'Network does not support the route',
      71  => 'Feature is not possible with the route',
      80  => 'Handover to SMSC failed',
      100 => 'SMS has been sent successfully'
    }.freeze

    def deliver
      response = post URI.encode_www_form params

      if 'ERROR_LOGIN' == response.body
        @error_code = 50
        @error_message = ERROR_CODES[50]
        return
      end

      parsed_response = response.body.split "\n"
      status     = parsed_response.shift
      message_id = parsed_response.shift

      if '100' == status
        message_id.to_i
      else
        @error_code = status.to_i
        @error_message = ERROR_CODES[status.to_i]
        nil
      end
    end

    def params
      default_params.merge(params_from_data).tap do |p|
        p[:message_id] ||= 1
        p[:message]    ||= data[:text]
      end
    end

    def param_names
      [
        :message, :to, :from, :route, :dlr, :message_id,
        :debug, :cost, :count, :response, :ref, :concat, :senddata
      ]
    end

    def default_params
      {
        key:   config.gateway_key,
        from:  config.sender,
        route: config.route,
        dlr:   1
      }
    end

    def params_from_data
      data.select { |k, _| param_names.include? k.to_sym }
    end

  end

  register sms_trade: SmsTrade

end
