Rails Forms
-----------

### TL;DR

`form_for` works well for forms that manage CRUD
- i.e. the Post model on a blog, because it will use the standard ActiveRecord setup

`form_tag` works well for forms that are not directly connected to models.
- a search bar, for instance


### form_tag

- Most basic form helper available in Rails
- Uses tag form elements to build out a form
- Doesn't use a form builder

```html
<%= form_tag("/cats") do %>
  <%= label_tag ('cat[name]', 'Name') %>
  <%= text_field_tag('cat[name]') %>

  <%= label_tag ('cat[color]', 'Color') %>
  <%= text_field_tag('cat[color']') %>

  <%= submit_tag "Create Cat" %>
<% end %>
```

Will auto-generate:
```html
<form accept-charset="UTF-8" action="/cats" method="POST">
  <label for="cat_name">Name</label>
  <input id="cat_name" type="text" name="cat[name]">

  <label for="cat_color">Color</label>
  <input id="cat_color" type="text" name="cat[color]">
  <input type="submit" name="commit" value="Create Cat">
</form>
```

### form_for

- more magical form helper in Rails
- `form_for` is a ruby method into which a ruby object is passed
  - directly connects the form with an ActiveRecord model
- yields a form builder object
  - that lets you create form elements to correspond to elements in the model

The `form_for` method is passed an object and it creates corresponding inputs with each of the attributes.
  - `form_for(@cat)` would have params like `cat[name]` and `cat[color]`

```html
<%= form_for(@cat) do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>
  <%= f.label :color %>
  <%= f.text_field :color %>
  <%= f.submit %>
<% end %>
```

Will auto-generate:

```html
<form accept-charset="UTF-8" action="/cats" method="post">
  <label for="cat_name">Name</label>
  <input id="cat_name" type="text" name="cat[name]">

  <label for="cat_color">Color</label>
  <input id="cat_color" type="text" name="cat[color]">
  <input type="submit" name="commit" value="Create">
</form>
```

#### Differences between form_for and form_tag

`form_for` is an advanced form helper that generates a form

`form_tag` is a lower-level form helper that generates a form, requiring element tags

`form_tag` makes no assumptions about what you're trying to do
- You're responsible for specifying exactly what the form is supposed to do
  - (sending a `post` request, `patch` request, etc.)

`form_for` handles the retrieval of values from your object model
  - will also try to route the form to the appropriate action specified in the controller


### Other Form elements

#### collection_check_boxes

`collection_check_boxes` assumes that there is a `many-to-many` relationship in palce
- books have many authors, authors have many books
  - `collection_check_boxes` are used with a form builder in a `form_for`

```html
<%= form_for(@book) do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>

  <%= f.collection_check_boxes :author_ids, Author.all, :id, :name %>

  <%= f.submit %>
<% end %>
```
`f.collection_check_boxes` - the method to generate the field

`:author_ids` - an empty collection that will be filled with the checked selections

`Author.all` - what collection will have boxes made for it

`:id` - what will be passed to `author_ids` for each selected item

`:name` - the attribute of the author that will be rendered on the page next to the checkbox

#### collection_select

Assumes a one-to-many relationship.

- a **movie** `has_one` **director** and a **director** `has_many` **movies**

```html
<%= form_for(@movie) do |f| %>
  <%= f.label :name %>
  <%= f.text_field :name %>

  <%= f.collection_select :director_id, Director.all, :id, :name %>

  <%= f.submit %>
<% end %>
```

`f.collection_select` - generates a drop-down selection box

`:director_id` - is the association of the movie object that the form will make upon submission

`Director.all` - provies the collection of all directors from the database to the drop-down elements

`:id` - will be associated to the `movie.director_id`

`:name` - the attribute that is shown in the drop-down menu

## Resources in routes.rb

- Probably the biggest difference between Sinatra and Rails
- in Sinatra, in app.rb you had blocks that corresponded to each path (router and controller as one)
- In rails, this convention separates the routes and the controllers
- Via the `resources` parameter, Rails metaprograms several routes for you that correspond to specific actions(`get`, `post`, `patch`)
