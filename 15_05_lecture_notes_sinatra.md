Sinatra
-------

A gem wrapper for a Rack application

**config.ru**
```ruby
require_relative 'config/environment'
use AlbumsController      # This is a bit of a hack. Flatiron Approved. Steven Frowned Upon
run ArtistController

# Better:
# We use MAP here because the rackup file doesn't know get.
map "/albums" do
  run AlbumsController
end

map "/artists" do
  run ArtistsController
end

run HomeController
```

Gemfile
```ruby
gem 'shotgun'
gem 'pry'
gem 'sinatra', require 'sinatra/base'

gem 'activerecord', require 'active_record'
gem 'sqlite3'
```

app/controllers/artists_controller.rb
```ruby
class ArtistController < ApplicationController
  # set :root, "#{__dir__}/.." # Only necessary if not using ApplicationController super class
   get '/?' do  # The /? lets a user put in a dangling slash at the end without returning an error
    @artists = Artist.all
    erb :"artists/index.html"
  end

  get '/:id' do      # making :id a symbol makes it variable. Sinatra will capture this value and assign it to the Sinatra parameter "id"
    @artists = Artist.find(params[:id])
    erb :"artists/show.html"
  end
end
```

```ruby
class HomeController
    set :root, "#{__dir__}/.."
    get '/' do
      erb :"home/index.html"
    end
end
```

app/controllers/application_controller.rb

Require this in the environment
```ruby
class ApplicationController < Sinatra::Base
  set :root, "#{__dir__}/.."

end
```

Source Code for the Twitter Gem would probably be a good thing to look at

GitHub OctoKit

Rack Libraries
