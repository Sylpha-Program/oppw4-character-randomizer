class CharactersController < ApplicationController

  def index
    @characters = Character.order(id: :asc)
  end

  def show
    @character = Character.find(params[:id])
  end

  def random
    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @character = Character.order(rand).first
    session[:character_id] = @character.id
    redirect_to root_url
  end
  
end
