# ruby-refactor

This is an automated refactoring tool for ruby that's agnostic to text editor. Currently, this is in very early stages, you can follow progress on https://trello.com/b/ezFGompY/ruby-refactoring

## Installation

Install with:

    $ gem install ruby-refactor

## Usage

In the backlog is a script to apply refactorings, but for now you'll have to use the console. To extract lines 3-5 of a new method, you would do something like this:

	require "ruby_refactor"
	RubyRefactor.extract_method("some_file_name.rb", name: "new_method", lines: 3..5)
	
Don't expect a lot out of it at this point. All it can do is extract lines with no arguments or return value, only works on ruby 2.6.3, and will completely change the formatting of all the code in that file.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

[![CircleCI](https://circleci.com/gh/lackita/ruby-refactor/tree/master.svg?style=svg)](https://circleci.com/gh/lackita/ruby-refactor/tree/master)

Bug reports and pull requests are welcome on GitHub at https://github.com/lackita/ruby-refactor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

Standards on accepted commits will be high. If you've read [https://smile.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/ref=sr_1_2?keywords=clean+code&qid=1566305114&s=gateway&sr=8-2](Clean Code) it can give you an idea of what I'm looking for. Here are a few examples of what I expect:

* Everything is developed using TDD
* For any change that's not a refactoring, a high level acceptance test should be added in `spec/acceptance`
* Methods are small
* Names are descriptive

I understand these are tough ideals to meet, I have difficulty reaching them as well. What I'm looking for is that you've put some thought and effort into keeping the code clean.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v1.4%20adopted-ff69b4.svg)](CODE-OF-CONDUCT.md)

Everyone interacting in the ruby-refactor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lackita/ruby-refactor/blob/master/CODE_OF_CONDUCT.md).
