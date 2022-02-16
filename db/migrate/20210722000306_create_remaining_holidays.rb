class CreateRemainingHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :remaining_holidays do |t|
      t.float      :last_year_days                        , null: false
      t.integer    :last_year_time                        , null: false
      t.float      :this_year_days                        , null: false
      t.float      :total_days                            , null: false
      t.integer    :total_time                            , null: false
      t.string     :working_hours                         , null: false
      t.references :user, foreign_key: true               , null: false
      t.float      :changeable_days                       
      t.integer    :changeable_time    
      # 申請により、引かれた残りの時間をtime_limitと定義している   
      t.integer    :time_limit
      t.timestamps

      # 有効期間
      t.date      :effective_period_start
      t.date      :effective_period_end
      # 備考
      t.string    :reason 
      # 入社年月日
      t.date      :joining_date    
    end
  end
end
