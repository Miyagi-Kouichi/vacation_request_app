class HolidaysController < ApplicationController
     before_action :authenticate_user!
     before_action :set_current_user, only: [:index, :new, :edit, :show, :update,]
     before_action :set_r_holiday, only: [:index, :new, :create, :edit, :show, :update, :cancel_new, :cancel_create]
     before_action :set_group, only: [:index, :new, :create]

     def index
     #     @holiday = Holiday.all.includes(:user)
          @holiday = current_user.holidays.all
          @week_holidays = current_user.WeekHolidayChanges.all
     end

     def new
          @holiday = Holiday.new
     end

     def create
          @holiday = Holiday.new(holiday_params)
          if @holiday.valid?
               holiday_calculation
               @holiday.save
               redirect_to root_path
          else
               render action: :new
          end
     end

     def cancel_create
          @holiday = Holiday.new(holiday_params)
          if @holiday.valid?
               holiday_cancel_calculation
               @holiday.save
               redirect_to root_path
          else
               render action: :new
          end
     end

     def cancel_new
          @user = current_user
          @holiday = Holiday.new
     end

     def show
          @h = Holiday.find(params[:id])
          @request = Request.find_by(holiday_id: @h.id)
          @comment = Comment.new
          @comments = @h.comments
     end

     def edit
          @holiday = Holiday.find(params[:id])
     end
          
     def update
          @holiday = Holiday.find(params[:id])
          if @holiday.update(holiday_params)
               @holiday.requests.destroy_all
               holiday_calculation
               redirect_to holiday_path(@holiday.id)
          else
               render :new
          end
     end    

     def destroy
          @holiday = Holiday.find(params[:id])
          @holiday.destroy
          redirect_to root_path
     end

     

       

          
     private
     # ストロングパラメータ
     def holiday_params
          params.require(:holiday).permit(:application_date, :acquisition_days, :holiday_time_start, :holiday_time_end, :acquisition_time, :reason).merge(user_id: current_user.id)
     end 
 
     def set_current_user
          @user = current_user
     end

     def set_group
          @group = current_user.groups
     end


     def set_r_holiday
          @r = RemainingHoliday.find_by(user_id: current_user.id)
     end

     def find_group
          group_user = GroupUser.find_by(user_id: @h.user_id)
          group_id = group_user.group_id
          @group = Group.find_by(id: group_id)
     end

     def holiday_calculation
          if @holiday.acquisition_days == "時間休"
               if @r.changeable_time.to_i >= @holiday.acquisition_time.to_i
                    @r.changeable_time -= @holiday.acquisition_time.to_i
                    @r.time_limit -= @holiday.acquisition_time.to_i
               elsif @r.changeable_time.to_i < @holiday.acquisition_time.to_i && @r.working_hours == "7時間制"
                    @r.changeable_days -= 1
                    @r.changeable_time += (7 - @holiday.acquisition_time.to_i)
                    @r.time_limit -= @holiday.acquisition_time.to_i
               elsif @r.changeable_time.to_i < @holiday.acquisition_time.to_i && @r.working_hours == "8時間制"
                    @r.changeable_days -= 1
                    @r.changeable_time += (8 - @holiday.acquisition_time.to_i)
                    @r.time_limit -= @holiday.acquisition_time.to_i
               end
          elsif @holiday.acquisition_days.in?(["午前・半休", "午後・半休" ]) && @r.changeable_days >= 0.5
               @r.changeable_days -= 0.5
          elsif @holiday.acquisition_days == "1日" && @r.changeable_days >= 1
               @r.changeable_days -= 1
          end
          @holiday.time_record = @r.changeable_time
          @holiday.day_record = @r.changeable_days
          @r.save
     end

     def holiday_cancel_calculation
          if @holiday.acquisition_days == "時間休キャンセル"
               @r.changeable_time += @holiday.acquisition_time.to_i
               @r.time_limit += @holiday.acquisition_time.to_i
          elsif @holiday.acquisition_days == "半休キャンセル"
               @r.changeable_days += 0.5
          elsif @holiday.acquisition_days == "1日キャンセル" 
               @r.changeable_days += 1
          end
          @holiday.time_record = @r.changeable_time
          @holiday.day_record = @r.changeable_days
          @r.save
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