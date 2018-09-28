# Ruby::Lichess

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-lichess'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-lichess

## Usage

Creating a client

```
client = Lichess::Client.new([token])
```

### Users

All Top Ten

```
result = lichess.users.all_top_ten()
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/omgrr/ruby-lichess.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
