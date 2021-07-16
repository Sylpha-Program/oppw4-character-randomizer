class StagesController < ApplicationController

  def index
    @stages = Stage.order(id: :asc)
  end

  def show
  end

end
