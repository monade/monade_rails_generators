# Monade Rails Generators

![Tests](https://github.com/monade/monade_rails_generators/actions/workflows/test.yml/badge.svg)

A generator for mònade workflow.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'monade_rails_generators'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install monade_rails_generators

## Usage

Basic CRUD, no authentication:
```bash
$ rails g crud Person first_name:string last_name:string
```

Basic CRUD, with authentication:
```bash
$ rails g crud Person first_name:string last_name:string --authenticated=true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/monade/monade_rails_generators.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

About Monade
----------------

![monade](https://monade.io/wp-content/uploads/2021/06/monadelogo.png)

monade_rails_generators is maintained by [mònade srl](https://monade.io/en/home-en/).

We <3 open source software. [Contact us](https://monade.io/en/contact-us/) for your next project!
