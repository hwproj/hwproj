class GroupsController < ApplicationController
  before_action :set_group, only: [ :show, :edit, :update ]

  def index
    @groups = Group.all
  end

  def show
    if signed_in? && current_user.teacher?
      @students = @group.users
    else
      @students = @group.users.select{ |student| student.approved }
      @student_tasks = current_user.tasks if signed_in?
    end

    @tasks_left = @group.tasks_left

    @homeworks = @group.homeworks
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(groups_params)
    @group.teacher_id = current_user.id
    @group.save
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
