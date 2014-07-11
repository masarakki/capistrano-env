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


#### 1. set env names in deploy.rb

```ruby
capenv.use do |env|
  env.add /^MYAPP_/
  env.add /^MYAPP_/ do |key|
     key.gsub /^MYAPP_/, '' # replace keyname like MYAPP_DATABASE_URL => DATABASE_URL
  end
  env.add 'UNICORN_PROCESSES'
  env.add 'HOGE', 'hage'
end
```

#### 2. deploy

```
bundle exec cap production deploy
```

- automaticaly create #{current_path}/capenv.rb
- automaticaly load #{current_path}/capenv.rb in rails boot
  - you should load manualy in other framework
- you can use ENV['ENV_NAME'] in application

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
