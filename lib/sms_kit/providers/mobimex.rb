require 'sms_kit/provider'
require 'json'

module SmsKit
  class Mobimex < Provider

    ROUTE_AFRICA = 'AFRIKA'.freeze

    HTTP_ENDPOINT = 'https://gate.quadra-mm.com/feed/http.asp'
    RESPONSE_FORMATS = { text: 0, xml: 1, json: 2 }

    # response json looks like this:
    # {"procedure":"SMS Feed","result":1,"description":"DONE: SMS is in the send queue."}
    def deliver
      response = post params
      if response.body.length > 1
        json = JSON.parse(response.body)
        json['result'].to_i == 1
      else
        nil
      end
    end

    def params
      {
        user:        config.username,
        pass:        config.password,
        dlr:         data[:dlr_profile] || 0,
        xml:         response_format,
        from_number: data[:from] || config.sender,
        number:      data[:to],
        message:     data[:text],
        idd:         data[:idd] || 0,
        im:          data[:im] || 0,
        route:       data[:route] || config.route,
        type:        data[:type] || 'text'
      }.reject { |k, v| v.nil? }
    end

    def response_format
      RESPONSE_FORMATS.fetch data[:format], :json
    end

    def post payload
      connection.post do |req|
        req.url uri.path
        req.headers['Content-Type'] = 'application/json'
        req.body = payload.to_json
      end
    end

  end

  register mobimex: Mobimex

end
