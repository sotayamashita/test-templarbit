# Templarbit Ruby Library [![Build Status](https://travis-ci.org/templarbit/templarbit-ruby.svg?branch=master)](https://travis-ci.org/templarbit/templarbit-ruby)

## Installation

Add this line to your application's Gemfile:

```
gem 'templarbit'
```

### Rails

In `config/initializers/templarbit.rb`:

```ruby
Templarbit.configure do |config|
  config.property_id = "test"
  config.secret_key = "test"
end
```

### Sinatra or any other Rack-based app

```ruby
require 'templarbit'

use Templarbit::Rack

Templarbit.configure do |config|
  config.property_id = "test"
  config.secret_key = "test"
end
```

## Usage

```ruby
# Set current user for session
Templarbit.current_user(user.id, user.email, user.name)
```
