Model View Controller
---------------------

Files have single responsibilities under this framework

Advantages over writing an application in a single file:

- Readability
- Easier to debug - hunting bugs in one megafile would suck.

##### Model
The Logic behind the application.
- Where you would check user entry against your data.
- Manipulate the data
-
##### View
- The HTML/CSS/Javascript
- Where the user interacts
- Written in **.erb** (embedded Ruby)

##### Controller
- The middle man between the *Model* and the *View*
- GET and POST request methods


View | Controller | Model
-----|-----------|------
Patron | Waiter | Chef
User| Ruby "Routes"  | Ruby Classes
