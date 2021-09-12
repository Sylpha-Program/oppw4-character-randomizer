class StagesController < ApplicationController

  def index
    @stages = Stage.order(id: :asc)
  end

  def show
    @stage = Stage.find(params[:id])
    @scores = Score.where(user_id: session[:user_id], stage_id: params[:id]).order(character_id: :asc)
    @total_point = @scores.sum(:point)
    @achievement_scores = Score.where(user_id: session[:user_id], stage_id: params[:id]).where.not(point: 0).count
    if @achievement_scores == 0
      @average_point = 0
    else
      @average_point = (@total_point / @achievement_scores).floor
    end
  end

end
