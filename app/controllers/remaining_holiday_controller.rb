class RemainingHolidayController < ApplicationController
     before_action :authenticate_user!

     def new
          @user = User.find(params[:user_id])
          @remaining_holiday = RemainingHoliday.new
     end

     def create
          @user = User.find(params[:user_id])
          @remaining_holiday = RemainingHoliday.new(remaining_holiday_params)
          if @remaining_holiday.valid?
              
               set_changeable_number
               set_time_limit
               @remaining_holiday.save
               redirect_to user_path(@user.id)
          else
            render action: :new
          end
     end



     def edit
          @user = User.find(params[:id])
          @remaining_holiday = RemainingHoliday.find_by(user_id: @user.id) # DBから既存のものを取得
     end
        
     def update
          @user = User.find(params[:id])
          @remaining_holiday = RemainingHoliday.find_by(user_id: @user.id)
          #  binding.pry
          if @remaining_holiday.update(remaining_holiday_params)
               set_changeable_number
               set_time_limit
               @remaining_holiday.save
               redirect_to user_path(@user.id)
          else
               render :new
          end
     end    
        
     private
     # ストロングパラメータ
     def remaining_holiday_params
          params.require(:remaining_holiday).permit(:last_year_days, :last_year_time, :this_year_days, :total_days, :total_time, :working_hours, :effective_period_start, :effective_period_end, :reason, :joining_date)
          .merge(user_id: @user.id)
     end

     def set_changeable_number
          @remaining_holiday.changeable_days = @remaining_holiday.total_days
          @remaining_holiday.changeable_time = @remaining_holiday.total_time
     end

     def set_time_limit
          if @remaining_holiday.working_hours == "7時間制"
               @remaining_holiday.time_limit = 35
          elsif @remaining_holiday.working_hours == "8時間制"
               @remaining_holiday.time_limit = 40
          end
     end

     # def set_user
     #      @user = User.find(params[:id])
     # end
end
