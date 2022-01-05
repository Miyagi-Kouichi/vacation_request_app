class GroupController < ApplicationController
     before_action :authenticate_user!
     before_action :set_group, only: [:edit, :show, :update, :destroy]

     def index
          @groups = Group.order('created_at')
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
          @group_holidays = Holiday.where(user_id: member_id)
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