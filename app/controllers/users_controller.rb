class UsersController < ApplicationController

  before_action :require_user_login, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]

  def show
    @total_point = Score.where(user_id: session[:user_id]).sum(:point)
    @level = Math.sqrt(@total_point).floor
    @next_level = (@level + 1) ** 2 - @total_point
    @achievement_rate = ((Score.where(user_id: session[:user_id]).where.not(point: 0).count.to_f / Score.where(user_id: session[:user_id]).count.to_f) * 100).round(2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @characters = Character.order(id: :asc)
      @stages = Stage.order(id: :asc)
      @characters.each do |character|
        @stages.each do |stage|
          Score.create(user_id: @user.id, character_id: character.id, stage_id: stage.id)
        end
      end
      session[:user_id] = @user.id
      flash[:success] = '登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "削除しました"
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end

end
