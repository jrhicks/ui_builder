# UI Builder

A High Productivity Stateful Server Rendered UI Framework for Rails

## Installation

### Add Gem to Gemfile

* Edit `Gemfile`

```ruby
gem 'ui_builder'
```

```bash
bundle install
```

### Configure Tailwind to Include Gem Views

* Edit `/app/config/tailwind.config.js`

```javascript
const execSync = require('child_process').execSync;
const ui_builder_path = execSync('bundle show ui_builder', { encoding: 'utf-8' });


module.exports = {
  content: [
    ui_builder_path.trim() + '/app/views/**/*.slim',
  ],
```

### Install Javascript

```bash
rails g ui_builder:install
```

Update `/app/javascript/application.js` 

```javascript
import UIBuilderListeners from './ui_builder_listeners'

(function () {
  window.Highcharts = Highcharts
  UIBuilderListeners.rememberScrollPositionOnTurboLoad()
  UIBuilderListeners.morphTurboFrameRenders()
})();
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ui_builder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/ui_builder/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UiBuilder project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ui_builder/blob/main/CODE_OF_CONDUCT.md).
