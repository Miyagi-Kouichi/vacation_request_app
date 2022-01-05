class NotificationsController < ApplicationController

     def create 
          # @holiday = Holiday.new(holiday_params)
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

     def destroy 
          destroy_user = Notification.find_by(user_id: params[:user_id]) 
          destroy_user.destroy
          redirect_to root_path, notice: "ユーザーをグループから退会しました。"      
     end


                    
     private
     # ストロングパラメータ
     

end
