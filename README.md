# SmsKit [![Build Status](http://ci.jamii.biz:8080/api/badge/github.com/jamii-Technologies/sms_kit/status.svg?branch=master)](http://ci.jamii.biz:8080/github.com/jamii-Technologies/sms_kit)

Easily send text messages via an HTTP SMS gateway.  
The goal is to offer one streamlined API for any provider adapter.

## Installation

Add this line to your application's Gemfile:

    gem 'sms_kit', github: 'jamii-Technologies/sms_kit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sms_kit

## Usage

### Configuration

You can store arbitrary options in a provider's configuration:

```
require 'sms_kit/providers/mobi_web'
SmsKit::MobiWeb.configure do |config|
  config.username = 'user'
  config.password = 'pass'
  config.sender   = 123456
end
```

### Send text message

Quickly:

```
SmsKit::MobiWeb.deliver text: 'Hello World.', to: 491231234567
```

Detailed:

```
provider = SmsKit::MobiWeb.new text: 'Hello World.', to: 491231234567
result   = provider.deliver

# returns the message id from MobiWeb or nil if something went wrong
puts result // 1234
```

#### Error handling

SmsKit will throw a `SmsKit::DeliveryError` if something goes wrong.
Though it depends on the specific provider this generally happens
upon authentication errors as well as returned error codes from the web service.

```
begin
  provider = :provider_symbol
  SmsKit.deliver text: 'hello world', to: '...', provider: provider
rescue SmsKit::DeliveryError => e
  logger.error e
end
```

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
