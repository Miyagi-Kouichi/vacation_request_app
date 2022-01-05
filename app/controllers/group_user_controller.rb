class GroupUserController < ApplicationController
     before_action :authenticate_user!
     # before_action :set_group, only: [:edit, :show, :update,]





     def create 
          @group = Group.find(params[:group_id]) 
          @user = User.find(params[:user_id]) 
          @group.users << @user
          if @group.save
               redirect_to group_user_path(group_id: @group.id, id: @group.id)
               # 将来的には、JavaScriptで非同期通信にしたい
          else
               render :new
          end
     end

     def show
          @group = Group.find(params[:id])
          @user = User.all
     end

     def destroy 
          destroy_user = GroupUser.find_by(user_id: params[:user_id]) 
          destroy_user.destroy
          redirect_to root_path, notice: "ユーザーをグループから退会しました。"      
     end

     private
     # ストロングパラメータ

     def set_group
          # @group = Group.find(params[:group_id])
     end

     def add_user
          @group = Group.find(params[:group_id])
          @user = User.find(params[:user_id])
          @group.users << @user
          redirect_to group_path, notice: "ユーザーを追加しました。"
     end
end