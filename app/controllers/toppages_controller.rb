class ToppagesController < ApplicationController

  def index
    if session[:character_id]
      @character = Character.find_by(id: session[:character_id])
      if session[:user_id]
        @level = Math.sqrt((Score.where(user_id: session[:user_id], character_id: session[:character_id]).sum(:total_point)) / 400).floor
      end
    end
  end

end
