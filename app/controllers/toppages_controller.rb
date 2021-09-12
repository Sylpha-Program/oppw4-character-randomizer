class ToppagesController < ApplicationController

  def index
    if session[:character_id]
      @character = Character.find_by(id: session[:character_id])
    end
    if session[:user_id]
      @total_point = Score.where(user_id: session[:user_id]).sum(:point)
      @level = Math.sqrt(@total_point).floor
      @next_level = (@level + 1) ** 2 - @total_point
      @achievement_scores = Score.where(user_id: session[:user_id]).where.not(point: 0).count
      @all_scores = Score.where(user_id: session[:user_id]).count
      @achievement_rate = ((Score.where(user_id: session[:user_id]).where.not(point: 0).count.to_f / Score.where(user_id: session[:user_id]).count.to_f) * 100).round(2)
      @average_point = (@total_point / @achievement_scores).floor
    end
  end

end
