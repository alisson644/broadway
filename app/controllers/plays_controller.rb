class PlaysController < ApplicationController

  def index; end

  def new
    @play = Play.new
  end

  def create 
    @play = Play.new(play_params)

    if @play.save
      redirect_to root
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
