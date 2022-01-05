class CreateWeekHolidayChanges < ActiveRecord::Migration[6.0]
  def change
    create_table :week_holiday_changes do |t|
      t.date    :original_leave            , null: false
      t.date    :changed_leave             , null: false
      t.belongs_to :user                   , null: false
      t.timestamps
    end
  end
end
