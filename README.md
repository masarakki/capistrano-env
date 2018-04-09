[![Build Status](https://travis-ci.org/masarakki/capistrano-env.svg?branch=master)](https://travis-ci.org/masarakki/capistrano-env?branch=master)
[![Dependency Status](https://gemnasium.com/masarakki/capistrano-env.svg)](https://gemnasium.com/masarakki/capistrano-env)
[![Coverage Status](https://img.shields.io/coveralls/masarakki/capistrano-env.svg)](https://coveralls.io/r/masarakki/capistrano-env?branch=master)

# Capistrano::Env

Capistrano with Env via file

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-env'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-env

## Usage

### 1. set env names in deploy.rb

in `Capfile`

```ruby
require 'capistrano/env'
```

in `deploy.rb`

```ruby
Capistrano::Env.use do |env|
  env.add /^MYAPP_/
  env.add /^MYAPP_/ do |key|
     key.gsub /^MYAPP_/, '' # replace keyname like MYAPP_DATABASE_URL => DATABASE_URL
  end
  env.add 'UNICORN_PROCESSES'
  env.add 'HOGE', 'hage'
  env.formatter = :dotenv #=> default is :ruby, but it is deprecated now.
  env.filemode = 0644 #=> default is 0640.
end
```

### 2. deploy

```
bundle exec cap production deploy
```

- automaticaly create #{current_path}/.env
- automaticaly load #{current_path}/.env if you use dotenv-rails
  - you should load manualy in other framework
- you can use ENV['ENV_NAME'] in application

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
