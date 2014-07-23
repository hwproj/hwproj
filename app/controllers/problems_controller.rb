class ProblemsController < ApplicationController

  def show
    @problem = Problem.find(params[:id])
  end

end
