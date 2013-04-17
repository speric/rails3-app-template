# copied from https://raw.github.com/RailsApps/rails3-application-templates/master/rails3-subdomains-template.rb
def copy_from(source, destination)
  begin
    remove_file destination
    get source, destination
  rescue OpenURI::HTTPError
    puts "Unable to obtain #{source}"
  end
end

puts "Creating a new Rails 3 app..."
puts "Adding gems..."

gem 'authlogic'
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'
gem 'will_paginate'

gem 'coffee-rails', '~> 3.2.1', :group => "assets"
gem 'uglifier', '>= 1.0.3', :group => "assets"

gem 'thin', :group => "development"
gem 'quiet_assets', :group => "development"
gem 'sextant', :group => "development"

puts "Installing gems..."
run "bundle install"

puts "Removing unnecessary default files..."
remove_file "public/index.html"
remove_file "app/assets/images/rails.png"

puts "Installing Bootstrap..."
run "rails generate bootstrap:install static"
# add 60 pix to body

puts "Generating User MVC"
generate(:model, "User")
generate(:controller, "Users")
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/models/user.rb", "app/models/user.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/controllers/users_controller.rb", "app/controllers/users_controller.rb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/_form.erb", "app/views/users/_form.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/edit.html.erb", "app/views/users/edit.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/new.html.erb", "app/views/users/new.html.erb"
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/views/users/index.html.erb", "app/views/users/index.html.erb"

#migration

puts "Generating UserSession MVC"
generate(:model, "UserSession")
generate(:controller, "UserSessions")
copy_from "https://raw.github.com/speric/rails3-app-template/master/app/models/user_session.rb", "app/models/user_session.rb"

#copy seeds

puts "Creating database..."
rake "db:create:all"

puts "Running migrations..."
rake "db:migrate"
rake "db:seed"
rake "db:test:prepare"

puts "Creating README.markdown..."
remove_file "README.rdoc"
create_file "README.markdown"

puts "Appending .gitignore..."
append_file '.gitignore' do <<-FILE
'.DS_Store'
'.rvmrc'
'/config/database.yml'
FILE
end

puts "Initializing git and making first commit..."
git :init
git :add => "."
git :commit => %Q{ -am 'Initial commit' }

puts "Done."