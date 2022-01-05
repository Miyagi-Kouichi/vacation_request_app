class WeekHolidayChange < ApplicationRecord
     belongs_to :user
     has_many :week_h_check, dependent: :destroy
end
