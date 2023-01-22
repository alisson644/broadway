class ReviewsController < ApplicationController
  before_action :set_play, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.play_id = @play.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to play_path(@play)
    else
      render :new
    end
  end

  private

  def set_play
    @play = Play.find(params[:play_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
