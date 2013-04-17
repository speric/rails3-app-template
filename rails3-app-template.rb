# copied from https://raw.github.com/RailsApps/rails3-application-templates/master/rails3-subdomains-template.rb
def copy_from(source, destination)
  begin
    remove_file destination
    get source, destination
  rescue OpenURI::HTTPError
    puts "Unable to obtain #{source}"
  end
end

#----------------------------------------------------------------------------
# Add and install gems
#----------------------------------------------------------------------------
puts "===> Adding gems"

gem 'authlogic'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'will_paginate'

gem 'coffee-rails', :group => "assets"
gem 'uglifier', :group => "assets"

gem 'thin', :group => "development"
gem 'quiet_assets', :group => "development"
gem 'sextant', :group => "development"

puts "===> Installing gems"
run "bundle install"

#----------------------------------------------------------------------------
# Remove cruft
#----------------------------------------------------------------------------
puts "===> Removing unnecessary default files"
remove_file "public/index.html"
remove_file "app/assets/images/rails.png"

#----------------------------------------------------------------------------
# Install Bootstrap, copy default app layout, fix body padding
#----------------------------------------------------------------------------
puts "===> Installing Twitter Bootstrap and default layout"
run "rails generate bootstrap:install static"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/layouts/application.html.erb", "app/views/layouts/application.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/shared/_form_errors.html.erb", "app/views/shared/_form_errors.html.erb"

append_file 'app/assets/stylesheets/bootstrap_and_overrides.css' do <<-EOS
body { padding-top: 60px; }
EOS

#----------------------------------------------------------------------------
# Generate User/UserSession, copy controllers, views, models, migrations
#----------------------------------------------------------------------------
puts "===> Generating User and UserSession MVC"
generate(:model, "User")
generate(:model, "UserSession")
run "rm -f db/migrate/*.rb"

generate(:controller, "Users")
generate(:controller, "UserSessions")

copy_from "https://raw.github.com/speric/rails3-app-template/master/app/controllers/application_controller.rb", "app/controllers/application_controller.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/models/user.rb", "app/models/user.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/controllers/users_controller.rb", "app/controllers/users_controller.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/_form.erb", "app/views/users/_form.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/edit.html.erb", "app/views/users/edit.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/new.html.erb", "app/views/users/new.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/index.html.erb", "app/views/users/index.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/db/migrate/20130417125112_create_users.rb", "db/migrate/20130417125112_create_users.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/models/user_session.rb", "app/models/user_session.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/controllers/users_sessions_controller.rb", "app/controllers/users_sessions_controller.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/user_sessions/new.html.erb", "app/views/users/new.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/db/seeds.rb", "db/seeds.rb"

#----------------------------------------------------------------------------
# Run migrations
#----------------------------------------------------------------------------
puts "===> Creating database"
rake "db:create:all"

puts "Running migrations"
rake "db:migrate"
rake "db:seed"

#----------------------------------------------------------------------------
# Create README, append gitignore
#----------------------------------------------------------------------------
puts "Creating README.markdown..."
remove_file "README.rdoc"
create_file "README.markdown"

puts "===> Appending .gitignore..."
append_file '.gitignore' do <<-FILE
'.DS_Store'
'.rvmrc'
'/config/database.yml'
FILE
end

#----------------------------------------------------------------------------
# Some sensible default routes
#----------------------------------------------------------------------------
puts "===> Adding some helpful routes"  
route("resources :users, :user_sessions")
route("match 'signin' => 'user_sessions#new', :as => :signin")
route("match 'signout' => 'user_sessions#destroy', :as => :signout")
route("match 'profile' => 'users#edit', :as => :profile")
route("root :to => 'users#edit'")

#----------------------------------------------------------------------------
# Initialize git
#----------------------------------------------------------------------------
puts "===> Initializing git and making first commit..."
git :init
git :add => "."
git :commit => %Q{ -am 'Initial commit' }

puts "FINISHED"