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

### Client

Get started by first creating a client

```
lichess = Lichess::Client.new(LICHESS_API_TOKEN)
```

### Users

*All Top Ten*

Get the top ten of all different types of games.

```
result = lichess.users.all_top_ten()
```

*Get leaderboard*

Get the leaderboard for the specified variant

```
result = lichess.users.leaderboard("blitz")
```

Can specify the number of users to get for the particular variant

```
result = lichess.users.leaderboard("blitz", 100)
```

*Get users*

Get a users data

```
result = lichess.users.get("username")
```

Get multiple users by passing in an array

```
result = lichess.users.get(["username1", "username2"])
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/omgrr/ruby-lichess.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
