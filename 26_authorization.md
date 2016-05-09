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

- We take user input and measure it against the username and password in the database
- Once these validations take place we have a logged-in user, with a `user.id` that we can persist in the session as `session[:user_id]`
- So, if you're logged in, the `session[:user_id]` with your ID should evaluate true
- If you are not logged in `session[:user_id]` should evaluate false
-

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
validates :username, uniqueness: true, presence: true
validates :email, uniqueness: true, presence: true

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
    redirect_to root_path, notice: "You have been logged in"
  else
    flash[:error] = "Bad username or password"
    redirect_to sign_in_path
  end
end
```

#### in `ApplicationController`
```ruby
class ApplicationController < ActionController::Base

  helper_method :logged_in?, :current_user
    # lets these methods be used across the controllers and views

  def logged_in?
    !!current_user
    # runs all the logic below, and checks that it exists.
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # first check if there's a user_id in the session
    # if there is one, look up that user by the session
    # we save (cache) @current_user to limit running this a million times
  end
```


```HTML
<% if logged_in? %>
  Welcome, <%= current_user.name %>
<% else %>
  We're in closed beta
<% end %>
```

#### User Registration

`rails g controller registrations`

`config/routes.rb`
```ruby
get 'sign-up', to: 'registrations#new'
post 'sign-up', to: 'registrations#create'
```

```ruby
class RegistrationController < ApplicationController
    def new
      @user = User.new
    end

    def create
      user = User.new(user_params)
      if user.save
        # sign_in_user(user) - this is a good candidate for refactoring
        session[:user_id] = user.id
        redirect_to root_path, notice: "Successful registration and login"
      else
        flash[:error] = "Add some more detailed information"
        redirect_to registrations_path,
      end
    end

    private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
```
- We need to validate
  - Unique usernames
  - Unique email

```HTML
  <%= form_for @user, url: sign_up_path do |f| %>
    <%= f.text_Field :email, placeholdeR: "Enter an email address" %>
    <%= f.text_field :username, placeholder: "Enter a username" %>
    <%= f.text_field :password, placeholder: "Enter a password" %>
    <%= f.text_field :password_confirmation, placeholder: "Confirm your password" %>
    <%= f.submit %>
```

Steven suggests breaking RESTful conventions in the case of registrations, because it's a specific pursuit.
 - The User model is going to get MASSIVE with logic in most projects, so this is an easy thing to tease out into it's own class
