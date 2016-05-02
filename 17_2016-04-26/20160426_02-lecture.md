Lab Review - Pirates! (Nested Forms)
-----------------------------------

Start with the bottom-up when building out a new application

Views and Models work OFF the database tables, so it makes sense to have the data to work with first


rake:db create_migration CreatePirates
```ruby
get '/all-of-the-things' do
  @things = AllOfTheThings.all
  erb :"things/index"
end

get '/all-of-the-things/new' do # This HAS TO COME BEFORE THE ID LOOKUP
  erb :"things/new"             # Otherwise /new will route to the dynamic segment
end                             # And try to find a thing with an id of 'new'

get '/all-of-the-things/:id' do
  @thing = AllOfTheThings.find(params[:id]) # the :id is a dynamic segment
  erb :"things/show"                        # it retrieves the id from the input URL
end

post '/all-of-the-things' do

end
```


```html
<form action="/pirates" method="POST">
  <label for="pirate_name">Name</label>  
  <input type="text" id="pirate_name" name="pirate[name]">
  <input type="submit" value="Submit">
</form>
```

Planning what you want your params to look like first, then building your nested form to give you the data you want

Why would we use `Pirate.new` over `Pirate.create`? Even though it means we have to save after?
