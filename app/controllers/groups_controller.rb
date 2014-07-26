class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @homeworks = @group.homeworks
  end

  def new
  end

  def create
    @group = Group.create(groups_params)
    redirect_to @group
  end

  private

    def groups_params
      params.require(:group).permit(:number, :year)
    end

end
