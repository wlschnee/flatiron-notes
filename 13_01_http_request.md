The HTTP Request
----------------

Request has two kinds of data
- Headers
- *Resource* or *Path* requested
  - For example `/search` or `/profile_name`

###### The Path

The Path lives in the HTTP request, so we inspect the `env` part of the `#call` function

`env` contains all the information in the request

```ruby
class App
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    resp.finish
  end
end
```

[See more on Rack::Requests](http://www.rubydoc.info/gems/rack/Rack/Request)

```ruby
Rack::Request #has a method #path
```

```ruby
class Application
  @@items = ["Apples", "Carrots", "Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)

      search_term = req.params["q"]

      if @@items.include?(search_term)
        resp.write "#{search_term} is one of our items"
      else
        resp.write "Couldn't find #{search_term}"
      end

    else
      resp.write "Path Not Found"
    end
    resp.finish
  end
end
```
