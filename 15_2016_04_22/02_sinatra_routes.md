Sinatra Routes
--------------

The part of the application that connects HTTP requests to specific methods

**Controller Action** - a method built to respond to HTTP requests

For instance:

```ruby
get '/medicines' do
  @medicines = Medicine.all
  erb :'medicines/index'
end
```

This get instance responds to the client request for the URL '/medicines'

Routes are constructed by using Sinatra DSL methods/verbs like `get` or `post`

Routes match the web request to a method in the program that tells the app what data and templates to send.

###### Here's the flow:
- App gets request `GET /medicines`
- Our Sinatra application will match `/medicines` to a route defined in a Controller
- The matching route looks like:
```ruby
get `/medicines` do
    # some code to get all the medicines
    # some code to render the correct HTML page
end
```

- Now that the request has been matched to a *controller action* it executes that controller action's block

```ruby
get `/medicines` do
  @medicines = Medicine.all

  erb :'medicines/index.html.erb'
end
```
