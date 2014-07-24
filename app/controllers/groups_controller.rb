class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @homeworks = @group.homeworks
  end

end
