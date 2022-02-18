# SimpleCov::SingleFile

Single file console output formatter for SimpleCov when running specs for single file.

You'll see the output with coverage only if you're running test for a single file:

    $ rspec spec/services/some_service_spec.rb

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simplecov-single_file'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simplecov-single_file

## Usage

Add `simplecov-single_file` to your Gemfile and bundle install:

```ruby
gem 'simplecov-single_file', require: false, group: :test
```

Require `simplecov-single_file` after `simplecov` **at the very top of your** `test/test_helper.rb` (or `spec_helper.rb`, `rails_helper.rb`, cucumber `env.rb`, or whatever your preferred test framework uses):
```ruby
require 'simplecov'
require 'simplecov/single_file'
```

Add formatter to SimpleCov:
```ruby
SimpleCov.formatter = SimpleCov::SingleFile::Formatter
# or
SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, SimpleCov::SingleFile::Formatter]
```

## Configuration
simplecov-single_file is configurable via Ruby code, generally in your test helper or setup file.
```ruby
SimpleCov::SingleFile.configure do |config|
  config.output_colorized = true
  config.output_style = :table
  config.output_green_threshold = 100
  config.output_orange_threshold = 80
  config.output_red_color = "\e[31m%<message>s\e[0m"
  config.output_green_color = "\e[32m%<message>s\e[0m"
  config.output_orange_color = "\e[33m%<message>s\e[0m"
end
```
All the configs above are default ones.

### Disabling colorized output
Color support is active by default. To disable:
```ruby
SimpleCov::SingleFile.config.output_colorized = false
```

### Output style
#### Table style (active by default)
Example output:
```
+-----------------------------------------+
|     SimpleCov Single File Coverage      |
+---------+-------------------------------+
| FILE:   | /app/services/some_service.rb |
+---------+-------------------------------+
| LINE:   | 100.0 -- 13/13 lines.         |
+---------+-------------------------------+
| BRANCH: | 50.0 -- 2/4 branches.         |
+---------+-------------------------------+
```
#### Block style
```ruby
SimpleCov::SingleFile.config.output_style = :block
```
Example output:
```bash
SimpleCov Single File Coverage
FILE: /app/services/some_service.rb
LINE: 100.0 -- 13/13 lines.
BRANCH: 50.0 -- 2/4 branches.
```
### Color thresholds
You can configure thresholds for colors:
```ruby
SimpleCov::SingleFile.config.output_green_threshold = 80
SimpleCov::SingleFile.config.output_orange_threshold = 43.5
```
By default `output_green_threshold` is 100 and `output_orange_threshold` is a value defined in `SimpleCov.minimum_coverage`.
Rules are the next:
```ruby
if file_coverage_percentage >= green_threshold
  # Use green color
elsif file_coverage_percentage >= orange_threshold
  # Use orange color
else
  # Use red color
end
```

### Colors
You can configure colors:
```ruby
SimpleCov::SingleFile.config.output_red_color = "\e[31m%<message>s\e[0m"
SimpleCov::SingleFile.config.output_green_color = "\e[32m%<message>s\e[0m"
SimpleCov::SingleFile.config.output_orange_color = "\e[33m%<message>s\e[0m"
```
It should be an ANSI color in format `"ANSI_COLOR%<message>s\e[0m"`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/floor114/simplecov-single_file. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/floor114/simplecov-single_file/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleCov::SingleFile project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/floor114/simplecov-single_file/blob/main/CODE_OF_CONDUCT.md).
