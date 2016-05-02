Intro to Rails
-------------

Rails is a *framework* built on top of Ruby
- A collection of tools that make the job easier
- Bootstrap is a front-end framework, does a lot of the lifting to make your site pretty


#### With pretty (Bootstrap) and functional (Rails) frameworks:

We can get to the work of making a site with content that is interesting.

###### Rails includes:
- ActionController for controllers
- ActionDispatch for routing
- ActionViews for views
- ActiveRecord for DB connection



###### What's the same:
- The app directory is the same
- ActiveRecord and Migrations are the same
- ERB is the same (sort of?)

###### What's different:
- Routing is VERY different
- The View is on steroids from where we were in Sinatra
  - Has security features, where to send forms (action and methods are pre-filled)
- Way more files available to us (We only work with a few)
  - Everything in the app/ directory and Gemfile, don't touch environment ever again (probably)
- New apps controllers models migrations and more are written for us on making a Rails apps

###### What's Better
- We get a tone of new (working!) Rake tasks
- Less typing
- A lot of repetitive tasks are gone
- No Setup. Just works
- Way more gems! (Rails specific gems)
  - Devise - handles user authentication. Includes password resets and stuff, just turn it on and magic.
- Stuff you don't know you need
  - Form submission protection, minifies stuff like styles etc to shrink the site somewhat. Etc.


#### Flow

- Web Server
- Router
- Controller action (controller instance method)
  - Gets data from the model
  - Generates HTML text from ERB
- Responds to request

Rails Lecture
-------------

The scaffold setup does some magic with the controller. At the top of scaffold generated controllers it sets the resource you're looking for (a student/teacher/etc) and sets that id in your show/edit/delete actions

**A partial** - separating parts of our UI generation into different files
  such as: <br><br>
  `render 'form'` links to a form file in `/app/views/_form` that contains the whole of the form. These start with underscores as standard
