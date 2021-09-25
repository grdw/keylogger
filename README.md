# Keylogger

[![CircleCI](https://circleci.com/gh/grdw/keylogger.svg?style=svg)](https://circleci.com/gh/grdw/keylogger)

A simple keylogger for logging keyboard events. Only works on these Ruby platforms:

```
x86_64-linux
x86_64-linux-gnu
```

More platforms will be added in the future.

## Usage:

```ruby
Keylogger.new("Name of keyboard").listen do |key|
  puts key
end
```

You can find the name of your keyboard in `cat /proc/bus/input/devices`.
