###Where does my code go?
  * Appropriate logic for controller:
      * session/authorization handling
      * parameter management: calling the correct model based on what params are passed in
      * rendering & redirecting

#####What's the problem with putting logic in the controller?

#####What's the problem with putting logic in the view?
---


###Common misconceptions & questions
  * Model is all about ActiveRecord
   * Any method can exist in a model 
    * Example: .to_s method that was in all the student labs
  * Iteration in view
  * Conditionals in controller
  * Role of helpers
  * Lib directory
  * All MVCs are the same
   * Other frameworks prioritize the contoller
   * Sometimes controller & views are integrated
   * Some frameworks have as thin a model as possible, or have the model deal only with data
  
 

###Best practices
  -Fat model, skinny controller

---

#####Examples
