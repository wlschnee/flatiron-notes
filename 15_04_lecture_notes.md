Processing Rack Requests
------------------------

Use the File class to get templates from another location

The browser does not understand ERB.

**config.ru**
```ruby
class App
  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path =="/"
      template = File.read('app/views/home/index.html.erb')
      response = ERB.new(template).result(binding)
      Rack::Response.new(response)
    elsif request.get? && request.path =="/artists"
      artists = Artist.all
      # This is also an index because it's an INDEX for ALL of the Artists
      template = File.read('app/views/artists/index.html.erb')  
      response = ERB.new(template).result(binding)              
      Rack::Response.new(response)
    elsif reqeust.get? && request.path ~= /\/artists\/.+/
      id = request.path.split("/").last
      artist = Artist.find(id)
      # The alternative is a SHOW page where we show info for an INSTANCE of Artist
      # template = File.read('app/views/artists/show.html.erb')
      # response = ERB.new(template).reseult(binding)
      # Rack::Resposne.new(response)

      # Moving the method to build show pages outside to a private method. Now we can call render_page_for with
      # different arguments to build show pages for different categories (artists, albums, genres, et)
      render_page_for("artists", "show", binding)
    else
      Rack::Response.new("File not found", 404)
    end
  end

  private
  def render_page_for(resource, page, state)
    template = File.read('app/views/#{resource}/#{page}.html.erb')
    response = ERB.new(template).reseult(state)
    Rack::Resposne.new(response)
  end
end
```

Binding says "whatever you have access to as of my appearance you have access to"

**app/views/home/index.html.erb**

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Home Page</title>
  </head>
  <body>
    Here's an awesome home page
  </body>
</html>
```

This example is a good candidate to be moved into the MVC convention

Model - just the data
- All the logic and data storage
View - a container waiting for you to give the data to express itself
- An HTML page rendered with information from the model
Controller - handles changes to the information
- Takes user input, manipulates the model, and causes the view to update appropriately.

```ruby
require_relative 'config/environment'
require 'erb'

class ApplicationController
  private
  def render_page_for(resource, page, state)
    template = File.read('app/views/#{resource}/#{page}.html.erb')
    response = ERB.new(template).reseult(state)
    Rack::Resposne.new(response)
  end
end

class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    render_page_for("artists", "index")
  end
  def show
    @artists = Artist.all
    render_page_for("artists", "show")
  end
end
class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render_page_for("albums", "index")
  end
end

class App
  def call(env)
    request = Rack::Request.new(env)
    if request.get? && requests.path == "/artists"
      controller = ArtistsController.new
      controller.index
    elsif request.get? && requests.path == "/albums"
      controller = AlbumController.new
      controller.index
    elsif request.get? && requests.path =~ /\/albums\/.+/
      controller = ArtistsController.new
      controller.show
    end      
  end
end
```

Router - code that sits between server and code to find a controller to call

Controller - code you will run to handle a request (determine what model or view it should be sent to)
