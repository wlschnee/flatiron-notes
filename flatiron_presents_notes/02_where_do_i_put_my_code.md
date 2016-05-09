### Where does my code go?
  * Appropriate logic for controller:
      * session/authorization handling
      * parameter management: calling the correct model based on what params are passed in
      * rendering & redirecting

##### What's the problem with putting logic in the controller?

##### What's the problem with putting logic in the view?
---

### Common misconceptions & questions
  * Model is all about ActiveRecord
  * Iteration in view
  * Conditionals in controller
  * Role of helpers
  * Lib directory



### Best practices
  -Fat model, skinny controller

----

##### Examples


OUTLINE:
--------

1. Restaurant Analogy

**The Chef - The Model**
- Knows the recipes, knows how to prepare the ingredients, knows which ingredients to use, makes the food from scratch

**The Waiter - The Controller**
- Knows his way around the restaurant, communicates with chefs to keep things flowing, doesn't cook but knows where to retrieve finished dishes

**The Table - The View**
- Where a customer (client's) order is taken by the waiter, communication with the the chef is carried out in preparation of the order, and once the finished dish is done it is delivered to the table for consumption.

2. Skinny Controller, Fat Model

- Dictates that you put the majority of logic in the models of MVC
  - Because it's conventional
    - Other developers will have an easier time debugging or adding features to your codebase
  - Because it's easily testable
    - Models are easily testable because they have a simple, single responsibility purpose
  - Because it plain looks better
    - Writing ERB tags is the pits.
  - It makes the code more reusable
    - Models don't have to be ActiveRecord related, and can be used as mix-ins to extend their functionality to multiple web requests

3. Where does my code go?!
  - Logic that should be in the controller
  - Logic that should be in the view
  - The rest goes in the Model (or Helpers?)

4. Welp Example
  - Smelly code
    - Lots of logic in the view is hard to read
    - Lots of logic in the controller is tricky to debug
  - Clean code
    - Highly readable, expressive
    -
