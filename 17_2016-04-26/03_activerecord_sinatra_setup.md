ActiveRecord Setup in Sinatra
-----------------------------

#### Gemfile

```ruby
    gem 'sinatra'
    gem 'activerecord'
    gem 'sinatra-activerecord'
    gem 'rake'
    gem 'thin'
    gem 'require_all'
    
    group :development do
      gem 'shotgun'
      gem 'pry'
      gem 'tux'
      gem 'sqlite3'
    end
    
    group :test do
      gem 'rspec'
      gem 'capybara'
      gem 'rack-test'
    end
```

`bundle install`

#### Connect to the Database - environment.rb

Set connection to sqlite3 database:

```ruby
  configure :development do
    set :database, "sqlite3:db/database.db"
  end
```

#### Make a Rakefile

`rake` gives us the ability to quickly make files and setup automated tasks (rake = RubymAKE)

` $ touch Rakefile `

in Rakefile:

```ruby
require './config/environment'
require 'sinatra/activerecord/rake'
```

`rake -T` Shows a list of available tasks

