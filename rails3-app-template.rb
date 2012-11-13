puts "Modifying existing Rails app..."

puts "Adding gems..."
gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'will_paginate', '~> 3.0'

group :assets do
  gem 'therubyracer', :platforms => :ruby
end

gem_group :development do
  gem 'sextant', '~> 0.1.3'
  gem 'quiet_assets', '~> 1.0.1'
end

puts "Installing gems..."
run "bundle install"

puts "Installing Bootstrap..."
run "rails g bootstrap:install"

puts "Removing unnecessary default files..."
remove_file "public/index.html"
remove_file "app/assets/images/rails.png"

puts "Appending .gitignore..."
append_file '.gitignore' do <<-FILE
'.DS_Store'
'.rvmrc'
'/config/database.yml'
FILE
end

puts "Creating database..."
rake "db:create:all"

#authlogic stuff

puts "Running migrations..."
rake "db:migrate"
rake "db:seed"
rake "db:test:prepare"

puts "Initializing git and making first commit..."
git :init
git :add => "."
git :commit => %Q{ -am 'Initial commit' }
