class CharactersController < ApplicationController

  def index
    @characters = Character.order(id: :asc)
  end

  def show
  end
  
end
