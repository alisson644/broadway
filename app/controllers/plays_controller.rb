class PlaysController < ApplicationController
  before_action :set_play, only: %i[show edit update destroy]

  def index
    @plays = Play.all.order('created_at DESC')
  end

  def show; end

  def new
    @play = Play.new
  end

  def create 
    @play = Play.new(play_params)

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
    params.require(:play).permit(:title, :description, :director)
  end
end
