class CharactersController < ApplicationController

  def index
    @characters = Character.order(id: :asc).page(params[:page]).per(33)
  end

  def show
    @character = Character.find(params[:id])
    @scores = Score.where(user_id: session[:user_id], character_id: params[:id]).order(stage_id: :asc)
    if session[:user_id]
      @level = Math.sqrt((Score.where(user_id: session[:user_id], character_id: params[:id]).sum(:total_point)) / 400).floor
    end
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
    @level = Math.sqrt((Score.where(user_id: session[:user_id], character_id: params[:id]).sum(:total_point)) / 400).floor
  end

  def score_update
    @score = Score.find_by(user_id: session[:user_id], character_id: params[:id], stage_id: params[:stage_id])
    @previous_level = Math.sqrt((Score.where(user_id: session[:user_id], character_id: params[:id]).sum(:total_point)) / 400).floor
    @score.total_point += params[:point].to_i
    @score.save
    @current_level = Math.sqrt((Score.where(user_id: session[:user_id], character_id: params[:id]).sum(:total_point)) / 400).floor
    if @current_level > @previous_level
      msg = "キャラクター：#{@score.character.name},ステージ：#{@score.stage.name},撃破数：#{params[:point].to_i}（過去最高：#{@score.max_point}）,レベル：Lv.#{@previous_level}→Lv.#{@current_level}"
      msg = msg.gsub(",","<br>")
      flash[:success] = msg
    else
      msg = "キャラクター：#{@score.character.name},ステージ：#{@score.stage.name},撃破数：#{params[:point].to_i}（過去最高：#{@score.max_point}）"
      msg = msg.gsub(",","<br>")
      flash[:success] = msg
    end
    if params[:point].to_i > @score.max_point
      @score.update(max_point: params[:point])
    end
    redirect_to root_url
  end
  
end
