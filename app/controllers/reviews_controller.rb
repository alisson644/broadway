class ReviewsController < ApplicationController
  before_action :set_play
  before_action :set_review, only: %i[edit update destroy]

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

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to play_path(@play)
    else
      render :edit
    end
  end

  def destroy
    @review.destroy

    redirect_to play_path(@play)
  end

  private

  def set_play
    @play = Play.find(params[:play_id])
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
