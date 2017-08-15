# ArtsyAuth::Gravity

A really simple authentication tool that uses the JWT to authenticate. 

### Meta

* __State:__ production
* __Point People:__ [@orta](https://github.com/orta), [@wrgoldstein](https://github.com/wrgoldstein)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'artsy-rack-auth-admin-only'
```

And then execute:

    $ bundle

## Usage

In your rack project, add the following ENV vars:

```sh
GRAVITY_URL = # A gravity API instance like https://api.artsy.net/
APPLICATION_ID = # Your ClientApplication's ID
APPLICATION_SECRET = # Your ClientApplication's secret
APPLICATION_INTERNAL_SECRET = # Your ClientApplication's internal secret, you can get this via gravity console
HOST = # Your site's public URL
```

Then inside the file where you're configuring your app, add:

```ruby
require "artsy-rack-auth-admin-only"
use ArtsyAuth::Gravity
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/artsy/artsy-rack-auth-admin-only.
