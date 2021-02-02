# Taking

A syntactical sugar for Pattern Matching like Elixir.

This is a very rudimentary implementation for testing, and may be expanded upon later as new ideas come up.

## Usage

Elixir allows us to pattern match on methods, this allows us to do it using Ruby's one-liner methods and argument forwarding (`...`):

```ruby
Point = Struct.new(:x, :y)

def handle_responses(...) = case Taking.from(...)
  in Point[x, 10 => y]
    Point[x, y + 1]
  in 1, 2, 3
    :numbers
  in 'a', 'b'
    :strings
  in :a, :b
    :symbols
  in x: 0, y: 0
    :origin
  in x: 0, y: (10..)
    :north
  else
    false
end

# Array-like

handle_responses(1,2,3)
# => :numbers
handle_responses('a', 'b')
# => :strings
handle_responses(:a, :b)
# => :symbols
handle_responses(:nope?)
# => false

# Hash-like

handle_responses(x: 0, y: 0)
# => :origin
handle_responses(x: 0, y: 15)
# => :north
handle_responses(x: 10, y: 15)
# => :false

# Deconstructable Object

handle_responses(Point[1, 10])
# => Point[1, 11]
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'taking'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taking

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/baweaver/taking. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Taking project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/baweaver/taking/blob/master/CODE_OF_CONDUCT.md).
