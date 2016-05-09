

MVC for Welp
table - :places 
  :meh_score
  :location
  :type

things that should exist:
  -calculate how mediocre something is based on meh score
  -update db when user adds a review w/ meh score
    -user can only submit stuff that is meeeeehhhhhhhh
  -rank meh stuff on index page
  
-smelly version:
  -view has code that determines order
  -controller determines mediocre rating 
  -model has validations and little else

-DRY version:
  -view logic: iteration over pre-sorted collection
  -controller logic: if sufficiently meh (.valid?) then update, if not meh enough => mediocre error, render :edit

class Places
  def self.mediocre
    self.all.sort_by{whatever}

class PlacesController
  def index
    @places = Places.mediocre

    smelly:
      @places = Places.all.sort_by(some whatever shit here)
    
