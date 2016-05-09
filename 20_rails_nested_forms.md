Basic Nested Forms
------------------

1. Construct a nested params hash referencing primary object & belongs to/has many association
2. Use conventional key names for associated data
3. Name form inputs correctly to create nested params with belongs to/has many data
4. Define a conventional association writer for primary model to properly instantiate associations from nested params
5. Define a custom association writer for the primary model to properly instantiate associations with custom logic on the nested params association data
6. Use **fields_for** to generate association fields


##### Data Model #####

Example: Address book
- People can have multiple addresses, and addresses have a bunch of address info fields

- **Person**
  - A person `has_many` addresses
  - `person.name` is a string
- **Address**
  - An address `belongs_to` one person
  - `address.street_address_1` : string
  - `address.street_address_2` : string
  - `address.city` : string
  - `address.zipcode` : string
  - `address.address_type` : string


```ruby
class Person < ActiveRecord::Base
  has_many :addresses
  accepts_nested_attributes_for :addresses
end
```

```erb
<%= form_for @person do |f| %>
  <%= f.text_field :name %>
  <%= f.fields_for :addresses do |addr| %>
    <%= addr.label :street_address_1 %>
    <%= addr.text_field :street_address_1 %><br />

    <%= addr.label :street_address_2 %>
    <%= addr.text_field :street_address_2 %><br />

    <%= addr.label :city %>
    <%= addr.text_field :city %><br />

    <%= addr.label :state %>
    <%= addr.text_field :state %><br />

    <%= addr.label :zipcode %>
    <%= addr.text_field :zipcode %><br />

    <%= addr.label :address_type %>
   <%= addr.text_field :address_type %><br />
 <% end %>
<% end %>
```

#### Use a "Stub" from the controller to generate the fields_for items ####

```ruby
class PeopleController < ApplicationController
  def new
    @person = Person.new
    @person.addresses.build(address_type: 'work')
    @person.addresses.build(address_type: 'home')
  end

  def create    
    @person = Person.create(person_params)
    redirect_to people_path(@person)
  end

  private

  def person_params
    params.require(:person).permit(:name)
  end
end
```
