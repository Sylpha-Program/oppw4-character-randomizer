class ToppagesController < ApplicationController

  def index
    if session[:character_id]
      @character = Character.find_by(id: session[:character_id])
    end
  end

end
