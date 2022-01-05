class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.date    :application_date                               , null: false
      t.time    :holiday_time_start                               
      t.time    :holiday_time_end                                 
      t.integer :acquisition_time                            
      t.string  :acquisition_days                               , null: false
      t.string  :reason                                         , null: false  
      t.integer :time_record                                    , null: false
      t.float   :day_record                                     , null: false
      t.belongs_to :user                                        , null: false
      t.timestamps
     

    end
  end
end
