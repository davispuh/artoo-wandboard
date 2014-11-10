# Artoo Adaptor For Wandboard

This repository contains the [Artoo](http://artoo.io/) adaptor for [Wandboard](http://wandboard.org/).

Artoo is a open source micro-framework for robotics using Ruby.

For more information about Artoo, check out repo at https://github.com/hybridgroup/artoo

## Installing

```
gem install artoo-wandboard
```

## Using

```ruby
require 'artoo'

connection :wandboard, :adaptor => :wandboard
device :led, :driver => :led, :pin => :JP4_4

work do
  every 1.second do
    led.on? ? led.off : led.on
  end
end
```

## Connecting

Run this Gem on Wandboard device itself.
