class CharactersController < ApplicationController

  def index
    @characters = Character.order(id: :asc)
  end

  def show
    @character = Character.find(params[:id])
  end
  
end
