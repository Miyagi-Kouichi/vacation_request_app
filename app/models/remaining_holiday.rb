class RemainingHoliday < ApplicationRecord
     belongs_to :user
     # has_many :holiday


     with_options presence: true do
          validates :last_year_days
          validates :last_year_time
          validates :this_year_days
          validates :total_days
          validates :total_time
          validates :working_hours
     end
end