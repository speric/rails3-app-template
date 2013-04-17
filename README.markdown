# A Rails 3 Application Template

An evolving set of the gems and patterns I currently use for Rails 3 development.  

Inspired by [https://github.com/defeated/rails-app-template](https://github.com/defeated/rails-app-template) and [https://github.com/npverni/rails3-rumble-template](https://github.com/npverni/rails3-rumble-template)

## Usage
After creating a new Rails app, and updating `config/database.yml`, run the following:
```
$ rake rails:template LOCATION=https://raw.github.com/speric/rails3-app-template/master/rails3-app-template.rb
```

Go to `http://localhost:3000`; the default admin username/pass is `foo@bar.com`/`password`.

## Gems

  * [authlogic](https://github.com/binarylogic/authlogic)
  * [twitter-bootstrap-rails](https://github.com/seyhunak/twitter-bootstrap-rails)
  * [will_paginate](https://github.com/mislav/will_paginate)

### Development

  * [Sextant](https://github.com/schneems/sextant/)
  * [Quiet Assets](https://github.com/evrone/quiet_assets/)
  * [Thin](https://github.com/macournoyer/thin/)