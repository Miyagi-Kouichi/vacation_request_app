class RequestController < ApplicationController
     before_action :authenticate_user!

     def agreement
          @request = current_user.requests.build(holiday_id: params[:holiday_id])
          check_position
          check_yes
          @request.save
          redirect_to root_path
     end

     def rejected
          set_holiday
          set_r_holiday
          reverse_calculation
          @request = current_user.requests.build(holiday_id: params[:holiday_id])
          check_position
          check_no
          @request.save
          redirect_to root_path
     end



     private
     # ストロングパラメータ
     

     def check_position
          @request.position = current_user.position           
     end 

     def check_yes
          @request.yes_no = "yes"
     end

     def check_no
          @request.yes_no = "no"
     end

     def set_holiday
          @holiday = Holiday.find_by(id: params[:holiday_id])
     end

     
     def set_r_holiday
          @r = RemainingHoliday.find_by(user_id: @holiday.user_id)
     end

     def reverse_calculation
          if @holiday.acquisition_days == "時間休"
               if @r.changeable_time.to_i >= @holiday.acquisition_time.to_i
                    @r.changeable_time += @holiday.acquisition_time.to_i
                    @r.time_limit += @holiday.acquisition_time.to_i
               elsif @r.changeable_time.to_i < @holiday.acquisition_time.to_i && @r.working_hours == "7時間制"
                    @r.changeable_days += 1
                    @r.changeable_time += (7 - @holiday.acquisition_time.to_i)
                    @r.time_limit += @holiday.acquisition_time.to_i
               elsif @r.changeable_time.to_i < @holiday.acquisition_time.to_i && @r.working_hours == "8時間制"
                    @r.changeable_days += 1
                    @r.changeable_time += (8 - @holiday.acquisition_time.to_i)
                    @r.time_limit += @holiday.acquisition_time.to_i
               end
          elsif @holiday.acquisition_days.in?(["午前・半休", "午後・半休" ]) && @r.changeable_days >= 0.5
               @r.changeable_days += 0.5
          elsif @holiday.acquisition_days == "1日" && @r.changeable_days >= 1
               @r.changeable_days += 1
          end
          @holiday.time_record = @r.changeable_time
          @holiday.day_record = @r.changeable_days
          @r.save
     end
end
