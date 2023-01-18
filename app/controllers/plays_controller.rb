class PlaysController < ApplicationController
  before_action :set_play, only: %i[show edit update destroy]

  def index
    return @plays = Play.all.order('created_at DESC') if params[:category].blank?

    @category_id = Category.find_by(name: params[:category])

    return @plays = [] if @category_id.blank?

    @plays = Play.where(category_id: @category_id.id).order('created_at DESC')
  end

  def show; end

  def edit 
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    @play.category_id = params[:category_id]
    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render :edit
    end
  end

  def destroy
    @play.destroy

    redirect_to root_path
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create 
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]

    if @play.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def set_play
    @play = Play.find(params[:id])
  end

  def play_params
    params.require(:play).permit(:title, :description, :director, :category_id)
  end
end
