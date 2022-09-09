class GroupUserController < ApplicationController
     before_action :authenticate_user!
     # before_action :set_group, only: [:edit, :show, :update,]

     def add_member
          @group = Group.find(params[:group_id]) 
          @user = User.find(params[:user_id]) 
          @group.users << @user
          if @group.save
               redirect_to group_add_page_path(group_id: @group.id)
          else
               render :add_page
          end
     end

     def add_page
          @group = Group.find(params[:group_id])
          @user = User.all
     end


       

     private
     # ストロングパラメータ

end