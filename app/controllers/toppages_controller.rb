class ToppagesController < ApplicationController

  def index
    if session[:character_id]
      @character = Character.find_by(id: session[:character_id])
    end
    if session[:user_id]
      @total_point = Score.where(user_id: session[:user_id]).sum(:point)
      @achievement_scores = Score.where(user_id: session[:user_id]).where.not(point: 0).count
      @all_scores = Score.where(user_id: session[:user_id]).count
      @achievement_rate = ((Score.where(user_id: session[:user_id]).where.not(point: 0).count.to_f / Score.where(user_id: session[:user_id]).count.to_f) * 100).round(2)
      if @achievement_scores == 0
        @average_point = 0
      else
        @average_point = (@total_point / @achievement_scores).floor
      end
    end
  end

end
