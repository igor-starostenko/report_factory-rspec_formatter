# ReportFactory::Rspec

*ReportFactory* helps you save each of your test runs so that they are always available for reports and analytics.
It consists of three parts:
1. A [rails server](https://github.com/igor-starostenko/report_factory) that provides an interface via JSON API and saves your test runs in a DB;
2. A [web dashboard](https://github.com/igor-starostenko/report_factory-web) which gives you an easy way to configure your test projects and reports;
3. And a test formatter that automatically sends reports to the server after each test run. This repo is the formatter for RSpec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'report_factory-rspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install report_factory-rspec

## Usage

Before you start using this formatter, make sure you have the [ReportFactory](https://github.com/igor-starostenko/report_factory) server deployed and running.

To setup this formatter to work with your RSpec tests, add this to your `spec_helper.rb` file:

```ruby
require 'report_factory-rspec'
```

and configure:

```ruby
ReportFactory::RSpec.configure do |config|
  config.url = "The url of the ReportFactory server. It's 'http://0.0.0.0:3000' if you're running locally"
  config.project_name = "The name of the project that you are testing. Needs to be previously created in ReportFactory"
  config.tags = ['Tags', 'to', 'help', 'you', 'group', 'your', 'reports']
  config.auth_token = "Your user X_API_KEY. Can be found in ReportFactory in your user information"
end
```

Then you can just simply run rspec with `--format ReportFactory::RSpec::Formatter` and your reports will be available on the server after each test run.
You can add that line to your `.rspec` file if you want it to be the default behavior.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/igor-starostenko/report_factory-rspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ReportFactory::Rspec project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/igor-starostenko/report_factory-rspec/blob/master/CODE_OF_CONDUCT.md).
