class GroupsController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destory]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destory]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def update

    find_group_and_check_permission

    if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    find_group_and_check_permission

    @group.destroy
    redirect_to groups_path, alert: "Group deleted"
  end


  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
