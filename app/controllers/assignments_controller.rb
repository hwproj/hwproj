class AssignmentsController < ApplicationController
  def new
    @assignment = Homework.new
  end
end
