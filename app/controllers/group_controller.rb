class GroupController < ApplicationController
     before_action :authenticate_user!
     before_action :set_group, only: [:edit, :show, :update, :destroy]
     protect_from_forgery :except => [:destroy]
     # , :change_holidays_show

     def index
          @groups = Group.all
          # .order(created_at: :desc)
          @user = User.find_by(id: current_user.id)
          @my_groups = GroupUser.where(user_id: current_user.id)
     end

     def new
          @group = Group.new
     end

     def create
          @group = Group.new(group_params)
          if @group.save
               redirect_to root_path
          else
               render :new
          end
     end

     def show
          member_id = @group.users.ids
          @group_holidays = Holiday.where(user_id: member_id).order(updated_at: :desc).page(params[:page]).per(10)
     end

     def change_holidays
          @group = Group.find(params[:group_id])
          member_id = @group.users.ids
          @group_change_holidays = WeekHolidayChange.where(user_id: member_id).order(updated_at: :desc).page(params[:page]).per(10)
     end

     def edit
          @group = Group.find(params[:id])
     end
          
     def update
          @group = Group.find(params[:id])
          if @group.update(group_params)
               redirect_to root_path
          else
               render :edit
          end
     end  

     def group_user
          @group = Group.find(params[:group_id])
          @user = User.all
     end

     def group_join 
          @group = Group.find(params[:group_id]) 
          @user = User.find(params[:user_id]) 
          @group.users << @user
          if @group.save
               redirect_to group_user_path(group_id: @group.id, id: @group.id)
               # redirect_to group_user_path(group_id: @group.id, id: @group.id)
               # 将来的には、JavaScriptで非同期通信にしたい
          else
               render :show
          end
     end

     def destroy
          group = Group.find(params[:id])
          group.destroy
          redirect_to :root
     end




     private
     # ストロングパラメータ
     def group_params    
          params.require(:group).permit(:group_name)
     end

     def set_group
          @group = Group.find(params[:id])
     end

end