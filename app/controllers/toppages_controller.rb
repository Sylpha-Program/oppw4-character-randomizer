class ToppagesController < ApplicationController

  def index
    if session[:character_id]
      @character = Character.find_by(id: session[:character_id])
    end
    if session[:user_id]
      @total_point = Score.where(user_id: session[:user_id]).sum(:point)
      @level = Math.sqrt(@total_point).floor
      @next_level = (@level + 1) ** 2 - @total_point
    end
  end

end
