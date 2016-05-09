Sinatra
-------

Sinatra is a Gem that gives us additional methods

#### app.rb
The less common way to use Sinatra

- Controller application.
- Handles all incoming requests to our application
- Sends back the appropriate response

```ruby
require 'sinatra'
class App < Sinatra::Base

end
```

```bash
$ rackup app.rb
```

### Modular Sinatra Applications

#####The more common way to use Sinatra

Brings in the `config.ru` file

`config.ru` - details the environment requirements of the application and starts the application

###### CONFIG.RU

```ruby
require 'sinatra' # loads the Sinatra Library

require_relative './app.rb' # Requires the Application file

run Application # Runs the application, represented by the ruby class Application
                # Application is defined in app.rb
```

###### APP.RB

```ruby
class Application < Sinatra::Base # Inherit Sinatra classes and methods. This class is now
                                  # referred to as a "Controller" and defines the HTTP interface
                                  # This class can be called anything, so long as it inherits
                                  # from Sinatra

  get '/' do                      # get is a DSL method, specific to Sinatra.
    "Hello, World!"               # Its counterpart is post
  end
end
```
