class RemainingHolidayController < ApplicationController
     before_action :authenticate_user!
     before_action :set_user

     def index
          @r = @user.remaining_holiday
          @remaining_holiday = RemainingHoliday.new
     end

     def create
          @remaining_holiday = RemainingHoliday.new(remaining_holiday_params)
          if @remaining_holiday.valid?

               set_changeable_number
               set_time_limit
               @remaining_holiday.save
               redirect_to root_path
          else
            render action: :new
          end
     end



     def edit
          @user = User.find_by(params[:user])
          @remaining_holiday = Remaining_holiday.find(params[:id]) # DBから既存のものを取得
     end
        
     def update
          # RemainingHoliday.find(params[:id]).update(remaining_holiday_params)
          remaining_holiday = RemainingHoliday.find(params[:id])
          remaining_holiday.update(remaining_holiday_params)
     end    
        
     private
     # ストロングパラメータ
          def remaining_holiday_params
               params.require(:remaining_holiday).permit(:last_year_days, :last_year_time, :this_year_days, :total_days, :total_time, :working_hours, :effective_period_start, :effective_period_end, :reason, :joining_date)
               .merge(user_id: @user.id)
          end

          def set_changeable_number
               # @remaining_holiday.total_time = @remaining_holiday.last_year_time
               @remaining_holiday.changeable_time = @remaining_holiday.total_time
               @remaining_holiday.changeable_days = @remaining_holiday.total_days
          end

          def set_time_limit
               if @remaining_holiday.working_hours == "7時間制"
                    @remaining_holiday.time_limit = 35
               elsif @remaining_holiday.working_hours == "8時間制"
                    @remaining_holiday.time_limit = 40
               end
          end

          def set_user
               @user = User.find(params[:user_id])
          end
end
