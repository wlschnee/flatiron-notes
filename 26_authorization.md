Parens help to signify order of evaluation to Ruby
<%= render(@posts) || "Nope" %>

#### Nested Form ####

```erb
<%= f.fields_for :comments, Comment.new do |comment_form| %>
  <%= comment_form.label :content %>
  <%= comment_Form.text_area :content %>
<% end %>
```

Comment.new defines the scaffold for what fields :comments should build into the form

```ruby
class Post < ActiveRecord::Base
  has_many :comments
  accepted_nested_attributes_for :comments

end
```

Sessions
----------
[Info about authentication and databasing in previous notes](./25_login_and_authentication.md)

`me.password` and `me.password_confirmation` have to match if you give `password_confirmation` any value. If you leave it blank it evaluates to true

has_secure_password gives us a method called `#authenticate`

`me.authenticate("password")` will evaluate the hashed `password_digetst`

```ruby
get 'sign-in', to: 'sessions#new'
post 'sign-in', to: 'sessions#create'
```

##### sign-in controller #####

```ruby
def new
  #code
end

def create
  user = User.find_by(username: params[:username])
  if user &&  password = user.authenticate(params[:password])
      # these two lines are too much logic for the controller
      # should be moved to the model in a class method
  else
    flash[:error] = "Bad Username" # this is a bad error message
    redirect_to sign_in_path
  end
end
```

Telling the page that a username doesn't exist gives too much information to bad actors.

**Don't** explicitly tell the user if it's a bad username OR password
A better error is `flash[:error] = "Bad username OR password"`

###### `user.rb` Authentication in the Model

```ruby
class User < ActiveRecord::BAse
  def self.authenticate(username, password)
    user = User.find_by(username: username)
    !!user && user.authenticate(password)
  end
end
```

###### `user_controller.rb`

```ruby
def create
  if user = User.authenticate(params[:username], params[:passowrd])
    session[:user_id] = user.id
  else
    flash[:error] = "Bad username or password"
    redirect_to sign_in_path
  end
end
```
