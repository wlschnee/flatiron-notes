ActiveRecord Validations
------------------------

### Validation
- Special method call
- Go at the top of model class definitions
- prevents them from being saved to the database if their data doesn't look right
- (Generally any code that performs the job of protecting the database from invalid code)

**AR validations are *NOT* database validations**

- Rails does not use the validation features offered by individual database types
  - By using ActiveRecord validations instead, we guarantee that we'll always get the same features regardless of what database is being used

# Custom Validators

### `#validate`

### subclassing `ActiveModel::EachValidator` and invoking with an inflected key in the options hash

### Subclassing `ActiveModel::Validator` and invoking with `#validates_with`

### Invalid data

Subtly wrong data (a phone number missing a digit for instance) can fuck up a database

### Basic Usage of ActiveRecord Validations

```ruby
class Person < ActiveRecord::Base
  validates :name, presence: true
end

Person.create(name: "John Doe").valid? # => true
Person.create(name: nil).valid? # => false
```

### Validation Helpers

To be used inside class definitions. When a validation fails an error message is added to the object's errors collection, and this message is associated with the attribute being validated

All helpers accept these options:
- `:on` - defines when the validation should be run
  - takes either `create` or `update` as a value
- `:message`  defines what kind of message should be added to the `errors` collection if it fails

## `acceptance`

- validates a required checkbox in the UI was checked (ex. an EULA agreement)
  ```ruby
    class Person < ActiveRecord::Base
      validates :terms_of_service, acceptance: true
    end
  ```

  - default error is :*must be accepted*
  - can receive an `:accept` option, which lets you set the desired return value to unchecked

## `validates_associated`
 - when trying to save an object will ensure the relationships to other objects are valid

## `confirmation`
- when two text fields must match (enter email or username twice)

- In the view template would look like:

```html
<%= text_field :person, :email %>
<%= text_field :person, :email_confirmation %>
```

```ruby
class Person < ActiveRecord::Base
  validates :email, confirmation: true
  validates :email_confirmation, presence: true
end
```

## `exclusion`



### What is the difference between `#new` and `#create`

`#new` instantiates a new AR model without saving it to the database

`#create` immediately attempts to save the instance to the database

**Database activity triggers validation** so it's important to be aware of the difference

- `#new` will not be validated because no attempt to write to the database was made
- using the `#valid?` method will trigger a validation without touching the database
