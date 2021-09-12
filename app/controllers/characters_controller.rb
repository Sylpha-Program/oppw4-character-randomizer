class CharactersController < ApplicationController

  def index
    @characters = Character.order(id: :asc).page(params[:page]).per(33)
  end

  def show
    @character = Character.find(params[:id])
    @scores = Score.where(user_id: session[:user_id], character_id: params[:id]).order(stage_id: :asc)
    @total_point = @scores.sum(:point)
    @achievement_scores = Score.where(user_id: session[:user_id], character_id: params[:id]).where.not(point: 0).count
    @average_point = (@total_point / @achievement_scores).floor
  end

  def random
    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @character = Character.order(rand).first
    session[:character_id] = @character.id
    redirect_to root_url
  end

  def score_edit
    @character = Character.find(params[:id])
    @stages = Stage.order(id: :asc)
  end

  def score_update
    @score = Score.find_by(user_id: session[:user_id], character_id: params[:id], stage: params[:stage_id])
    if params[:point].to_i > @score.point
      @difference = params[:point].to_i - @score.point
      @score.update(point: params[:point])
      flash[:success] = "撃破数が#{@difference}アップしました。"
    else
      flash[:success] = "撃破数は更新されませんでした。"
    end
    redirect_to root_url
  end
  
end
