class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  def show
    select_review   # Rails retrieves the appropraite view if you use RESTful controller names
  end
  def new
    @review = Review.new
  end
  def create
    @review = Review.create(scrubed_params) # the private #scrubbed_params method can also
    if @review.valid?                       # be used in the reviews#update controller
      @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end
  private
  def select_review
    @reivew = Review.find(params[:id])
  end
  def scrubed_params
    (params.require(:review).permit(:business_id, :user_id, :title, :content, :meh_rating))
  end
end
