Login and Authentication
------------------------
Base 64 Encoding

```ruby
include 'base64'
encoded_text = Base64.encode64("Here's some text to encode")
Base64.decode64(encoded_text) # => "Here's some text to encode"
```

SQL injections happen every day - so storing a password in a database is dangerous and storing it plainly is just unacceptable

One option is to use Google or Facebook's baked-in authentication to sign up for your site

### Hash a password

A function that

```ruby
require 'digest/sha1'

Digest::SHA1.hexdigest("password")
# => "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8"

Digest::SHA1.hexdigest("password1!")
# => "f71fe67a9e4b4ff8318c6773b088abcf3e537073"
```

This is not reversible, so you can't pass the hash into the same function and return the password

**This, however, is not the best way. SHA1 can be reversed engineered by building a lookup table for every hashed password**
 - Still safe if using passwords longer than ~ 14 characters including symbols, numbers and capitals

### Salting a password
Add unique information at the end of a password, then hash THAT instead of just the regular password

password = "password1" + "1bca0f05a18f09c9cc81307f671e12ef"

```ruby
Digest::SHA1.hexdigest("password")
```

We store the salted and hashed password along with the salt

```ruby
pass = Digest::SHA1.hexdigest"password"
# => "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8"
salt
# NameError: undefined local variable or method `salt' for main:Object
salt = SecureRandom.hex
# => "bf8cbfa227ce63a721f1d646f0df5cb8"
pass + salt
# => "5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8bf8cbfa227ce63a721f1d646f0df5cb8"
hashed = Digest::SHA1.hexdigest(pass + salt)
# => "e1eb2a920443cebfe25aa4356b467cd27ed3555d"
[hashed + "||||" + salt
=# > "e1eb2a920443cebfe25aa4356b467cd27ed3555d||||bf8cbfa227ce63a721f1d646f0df5cb8"
[stored = _
=# > "e1eb2a920443cebfe25aa4356b467cd27ed3555d||||bf8cbfa227ce63a721f1d646f0df5cb8"
```

**in Gemfile, uncomment out**

`gem 'bcrypt'`

rails g model user username email password_digest

in the model add the macro `has_secure_password`

1. Find a user by username (username should be indexed in the database)
2. user.authenticate("password")
  - returns the object if the password is right
  - returns `false` if the password is wrong

`rails g controller sessions` - where you go to create or destroy sessions

routes.rb:
```ruby
get 'sign-in', to: 'sessons#new', as: 'sign_in'
post 'sign-in', to: 'sessions#create' as: 'sign_in'
```

signin form:

```HTML
<%= form_tag "sign-in" do %>
  <%= text_field_tag :username, placeholder: "Enter your username" %>
  <%= text_field_tag :password, placeholder: "Enter your password" %>
<% end %>
```

SessionsController

```ruby
def new
end

def create
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    # Go somewhere awesome
  else
    redirect_to sign_in_path, notice: "Bad username or password"
  end
end
```

`session[:user_id] = @user.id`
