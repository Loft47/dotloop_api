# DotLoop API Library
[![Build Status](https://travis-ci.org/Loft47/dotloop_api.svg?branch=master)](https://travis-ci.org/Loft47/dotloop_api)
[![Coverage Status](https://coveralls.io/repos/github/Loft47/dotloop_api/badge.svg?branch=master&renew=true)](https://coveralls.io/github/Loft47/dotloop_api?branch=master)

This library is designed to help ruby applications consume the DotLoop API v2.

You can read more about the api from the official documentation at [https://dotloop.github.io/public-api](https://dotloop.github.io/public-api)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dotloop_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dotloop_api

## Usage

Optional parameters are prefixed with a __'*'__'

```ruby
    grant_response_url = ''

    auth = DotloopApi::Auth.new(
      application: 'dotloop',
      client_id: '00000000-ffff-eeee-1111-fff111fff111',
      client_secret: '11111111-eeee-ffff-0000-111fff111fff',
      redirect_uri: 'https://www.google.com',
    )
    puts "Initially you must visit this grant url an authenticate your Dotloop Account :#{auth.grant_uri}"
    puts "now set the grant_response_url to the response you get from the line above"

    if grant_response_url != ''
      auth.request_from_url(url)
    else
      auth.config.attributes = {
        access_token: '55555555-dddd-7777-0101-eeffeeffeeff',
        refresh_token: '77777777-cccc-5555-1010-ffeeffeeffee'
      }
    end

    client = DotloopApi::Client.new(access_token: auth.config.access_token)

    client.account #=>

    client.Profile.all  #=> get all profiles
    myprofile = client.Profile.all.last #=> get a profile
    myprofile.loops #=> get a profiles loops
    myloop = all_loops.last #=> get a single loop
    myloop.activity  #=> get loop activity
    myloop.folders  #=> get loop folders
    myloop.folders.last.documents #=> get folder documents

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dotloop_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
