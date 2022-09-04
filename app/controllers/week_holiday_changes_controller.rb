class WeekHolidayChangesController < ApplicationController
     before_action :authenticate_user!

     def index
          @week_holidays = WeekHolidayChange.all
     end

     def new
          @week_holiday = WeekHolidayChange.new
     end

     def create
          @week_holiday = WeekHolidayChange.new(week_holiday_params)
          if @week_holiday.valid?
               @week_holiday.save
               redirect_to week_holiday_changes_path
          else
               render action: :new
          end
     end

     def show
          @week_holiday = WeekHolidayChange.find(params[:id])
          @week_h_check = WeekHCheck.find_by(week_holiday_change_id: @week_holiday.id)
          # @comment = Comment.new
          # @comments = @h.comments
     end

     def edit
          @week_holiday = Holiday.find(params[:id])
     end
          
     def update
          @week_holiday = WeekHolidayChange.find(params[:id])
          if @week_holiday.update(week_holiday_params)
               @week_holiday.requests.destroy_all
               redirect_to week_holiday_change_path(@week_holiday.id)
          else
               render :new
          end
     end    

     def destroy
          @week_holiday = WeekHolidayChange.find(params[:id])
          @week_holiday.destroy
          redirect_to week_holiday_changes_path
     end


     private
     # ストロングパラメータ
     def week_holiday_params
          params.require(:week_holiday_change).permit(:original_leave, :changed_leave).merge(user_id: current_user.id)
     end 
end
