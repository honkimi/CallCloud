source 'https://rubygems.org'


gem 'rails', '4.1.5'
gem 'spring',        group: :development


## rails assets
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'bootstrap3-rails'
gem 'bootstrap-material-design'
gem 'jquery-jcanvas-rails', git: "https://github.com/danielRomero/jquery-jcanvas-rails.git"

# devise
gem 'devise'
gem 'devise-bootstrap-views'

# twilio
gem 'twilio-ruby'

group :production do
  # Production App Server
  gem 'unicorn'
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3'
  gem 'dotenv-rails', '0.11.1'

  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-debugger'

  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'pry-nav'

  gem 'binding_of_caller'

  gem 'tapp'
  gem 'awesome_print'
  gem 'quiet_assets'
end

