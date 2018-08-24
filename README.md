# Specfactor

Specfactor is a gem that generates commonly used tests for commonly used controller actions.

## Installation

Specfactor is dependent on these gems: 

    rspec-rails
    activesupport
    factory_bot_rails
    
Provided you are developing on Rails, activesupport should be included by default.
Specfactor generates tests that utilize factories, and so FactoryBot is recommended. Otherwise, simply comment out/delete parts of the tests you don't want to use.

Add this line to your application's Gemfile:

```ruby
gem 'specfactor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specfactor

## Usage

In terminal, type:

    specfac generate [controller] [actions]
    
__[controller]__ should be the name of the controller you'd like to generate tests for

__[actions]__ should be the names of methods to be generated

An example usage for specific tests:

    specfac generate participants index show
    
An example for all available tests:
    
    specfac generate participants ALL
    
An example generating a FactoryBot factory for the controller:

    specfac generate -f dogs ALL
    
Currently, tests can be generated for :index, :show, :new, :create, :edit, :update, and :destroy.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viktharien/specfacthor.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
