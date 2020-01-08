# SmsKit
[![Gem Version](https://badge.fury.io/rb/sms_kit.svg)](https://badge.fury.io/rb/sms_kit)
[![Build Status](https://travis-ci.org/jamii-Technologies/sms_kit.svg?branch=master)](https://travis-ci.org/jamii-Technologies/sms_kit)

Easily send text messages via an HTTP SMS gateway.  
The goal is to offer one streamlined API for any provider adapter.

## Installation

Add this line to your application's Gemfile:

    gem 'sms_kit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sms_kit

## Usage

### Configuration

You can store arbitrary options in a provider's configuration:

```rb
require 'sms_kit/providers/mobi_web'
SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end
```

### Send text message

```rb
provider = SmsKit::MobiWeb.new text: 'Hello World.', to: 491231234567
result   = provider.deliver

# returns the message id from MobiWeb or nil if something went wrong
puts result // 1234
```

There's also a short version:

```rb
SmsKit::MobiWeb.deliver text: 'Hello World.', to: 491231234567
```

### Sending "Objects"

If your class responds to `to_sms`, you can send it itself:

```rb
class TextMessage
  def to_sms
    {
      to: 491231234567
      text: 'hello world'
    }
  end
end

SmsKit.deliver :provider_name, TextMessage.new

# or on a provider level

class MyProvider < SmsKit::Provider
  # ...
end

MyProvider.deliver TextMessage.new

```

### Custom Provider

```rb
class MyProvider < SmsKit::Provider
  # default url that the built-in http client will use
  HTTP_ENDPOINT = 'https://www.example.com'.freeze

  # ...

  # custom connection configuration
  # the default implementation (`super`) accepts a block
  # which yields you a faraday instance
  def connection
    super do |conn|
      conn.headers[:user_agent] = 'custom user agent'
    end
  end
end
```

#### Error handling

SmsKit will throw a `SmsKit::DeliveryError` if something goes wrong.
Though it depends on the specific provider this generally happens
upon authentication errors as well as returned error codes from the web service.

```rb
begin
  provider = :provider_symbol
  SmsKit.deliver provider, text: 'hello world', to: '...'
rescue SmsKit::DeliveryError => e
  logger.error e
end
```

## Common SMS options

Which options the `#deliver` method expects generallly depends on provider implementation.
However, core providers expect the following options, at least:

- `:to` The number to send the message to
- `:from` The sender ID
- `:text` The text message

## Packaged providers

- CentralICT -- [www.centralict.com](http://www.centralict.com/)
- MobiWeb -- [mobile-sms.biz](http://mobile-sms.biz/)
- Mobimex -- [www.mobimex.com](http://www.mobimex.com/)
- smstrade -- [www.smstrade.de](http://www.smstrade.eu/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

SmsKit is released under the [MIT License](http://www.opensource.org/licenses/MIT).
