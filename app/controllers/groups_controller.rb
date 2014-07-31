class GroupsController < ApplicationController
  before_action :set_group, only: [ :show, :edit, :update ]

  def index
    @groups = Group.all
  end

  def show
    @homeworks = @group.homeworks
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.create(groups_params)
    redirect_to @group
  end

  def edit
  end

  def update
    @group.update(groups_params)
    redirect_to @group
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

    def get_groups
      @groups = Group.all
    end

    def groups_params
      params.require(:group).permit(:number, :year)
    end

end
