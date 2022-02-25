class UsersController < ApplicationController
  # before_action :set_user, only: [:show, ]
  # before_action :set_week_holiday_changes, only: [:show, ]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @r = @user.remaining_holiday  
    @holidays = @user.holidays
    @groups = Group.all
    # @week_holidays = @user.WeekHolidayChanges.find_by(params[user_id: @user.id])
    @week_holidays = WeekHolidayChange.all
  end

  def holiday
    @users = User.all
    @holidays = Holiday.all
  end

  def week_holiday_change
    @users = User.all
    @changes = WeekHolidayChange.all
  end


  def create 
    @notification = Notification.new
    @group = Group.find(params[:group_id]) 
    @user = User.find(params[:user_id]) 
    @notification.user_id = @user
    @notification.group_id = @group
    if @group.save
         redirect_to group_user_path(group_id: @group.id, id: @group.id)
         # 将来的には、JavaScriptで非同期通信にしたい
    else
         render :new
    end
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id]) 
    @user.update(user_params) 
    redirect_to :root
  end    

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    redirect_to :root
  end

  private
  # ストロングパラメータ
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :encrypted_password, :user_name, :position)
  end
end
