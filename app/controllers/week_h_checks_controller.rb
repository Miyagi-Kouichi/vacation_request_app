class WeekHChecksController < ApplicationController

    def agreement
          @check = current_user.week_h_checks.build(week_holiday_change_id: params[:week_holiday_change_id])
          check_position
          check_yes
          @check.save!
          redirect_to users_week_holiday_change_path
    end

    def rejected
          @check = current_user.week_h_checks.build(week_holiday_change_id: params[:week_holiday_change_id])
          check_position
          check_no
          @check.save
          redirect_to users_week_holiday_change_path
    end

    private
    # ストロングパラメータ

    def check_position
         @check.position = current_user.position           
    end 

    def check_yes
         @check.yes_no = "yes"
    end

    def check_no
         @check.yes_no = "no"
    end

end