Where's the logic in MVC?
-------------------------
## MVC History

**Ward Cunningham** - inventor of The WikiWikiWeb, first every user-editable website and basis of Wikipedia.
- [Model View Controller History](http://c2.com/cgi/wiki?ModelViewControllerHistory)

Been in use since Smalltalk at Xerox PARC in the 1970s and 80s

Grew in popularity with Apple's WebObjects application server and framework in 1996

Later became popular with Java developers when WebObjects was ported to Java from Objective-C

Although originally developed for desktop computing, it has become a widely adapted architecture in for World Wide Web applications in many different programming languages

Frameworks like *Rails, Django*, and *ASP.NET* from Microsoft all utilize **"thin client"** approaches, which locate the majority of the logic on the *server-side*.

Frameworks such as *Angular, Ember* have been used more recently that allow MVC components to execute on the *client side*.

**Problem domain** - all information that defines the problem and constrains the solution.
 - Includes the goals that the problem owner wishes to achieve
 - The context of the problem
 - All the rules that define essential functions or other aspects of any solution

Positioning domain - or business - logic in the model can allow discreet testing of that logic on the model to ensure the logic is fully working before outputting to the view.

**Controllers and Views are more difficult to discretely test**
- Since they call logic defined (and tested) elsewhere and are meant to pass an instance or collection of instances between a model and view, an instance must be created (or retrieved) in order to carry out a test

### The Kitchen Analogy

Three key components

**The Chef - *The Model***
- Knows the recipes, knows how to prepare the ingredients, knows which ingredients to use, makes the food from scratch

**The Waiter - *The Controller***
- Knows his way around the restaurant, communicates with chefs to keep things flowing, doesn't cook but knows where to retrieve finished dishes

**The Table - *The View***
- Where a customer (client's) order is taken by the waiter, communication with the the chef is carried out in preparation of the order, and once the finished dish is done it is delivered to the table for consumption.

### Reusability

The controller and view are fleeting depending on the client request, but the models are consistent and directly interact with the data persisted in the database layer.

**DRY**
By defining instance methods in the model (person.name, person.age, etc) it can now be called upon anywhere in any view without re-building those instance methods in the controller.

### Readability

- Keeping the view as **thin** as possible:
  - Makes it so much easier to read - calling on instance methods from the model and controller makes the view like almost bare HTML with just a touch of ERB

**Good:**
```html
<!-- /views/posts/index.html.erb -->
<div>
  <ul>
    <% @posts.each do |post| %>
      <li><%= link_to post.name, post_path(post) %></li>
    <% end %>
  </ul>  
</div>
```

**Bad:**
```html
<div>
  <ul>
    <% @posts = Posts.all  %>
      <% @posts.each do |post| %>
      <li><%= link_to post.name, posts_path(post) %></li>
      <% end %>
    <% end %>
  </ul>
</div>
```

### Maintainability

- Easy to suss out bugs when you know where all the heavy lifting logic is happening and you can test for it
- Any new programmer sitting down to debug or add a feature to your code will be able to trace your code since it follows accepted conventions

### Modularity


### Separation of Concerns

- Use POROs (Plain Old Ruby Objects) to build yet further functionality that doesn't need to be inside the model object that inherits from ActiveRecord::Base

Jamis Buck - [Skinny Controller, Fat Model](http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model)
 - worked at Basecamp (The project that inspired DHH to create Rails)

### ERB Tags are a PITA

### Domain vs Application logic

Business Logic - the part of a program that encodes the real-world "business rules" - rules that determine how data can be created, displayed, stored and changed.

Eric Evans in his book **Domain Driven Design** splits Business Logic into two types:
1. Domain Logic
2. Application Logic

**Domain Logic** corresponds to the actual domain, so in a blog rules about Posts, Categories,
