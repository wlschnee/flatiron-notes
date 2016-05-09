Using ERB
---------

1. Define and explain the benefits of view templating
2. Use ERB substitution and scripting tags to modify the content and structure of HTML code
3. Incorporate logic and iteration using ERB

**Substitution Tag**
`<%= %>`

Evaluates ruby code and displays the results into the view

**Scripting Tag**
`<% %>`

Evaluate, but do not display.

```ruby
<% if logged_in? %>
  <a href="/logout">Click here to logout</a>
<% else %>
  <a href="/login">Click here to logout</a>
<% end %>
```
