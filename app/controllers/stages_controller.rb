class StagesController < ApplicationController

  def index
    @stages = Stage.order(id: :asc)
  end

  def show
    @stage = Stage.find(params[:id])
    @scores = Score.where(user_id: session[:user_id], stage_id: params[:id]).order(character_id: :asc)
    @total_point = @scores.sum(:point)
    @achievement_scores = Score.where(user_id: session[:user_id], stage_id: params[:id]).where.not(point: 0).count
    @average_point = (@total_point / @achievement_scores).floor
  end

end
