class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|
      t.date    :application_date                               , null: false  #取得日（実際に休む日）
      t.time    :holiday_time_start                                            #時間休開始時間
      t.time    :holiday_time_end                                              #時間休終了時間
      t.integer :acquisition_time                                              #取得する時間休
      t.string  :acquisition_days                               , null: false  #有休タイプ
      t.string  :reason                                         , null: false  
      t.integer :time_record                                    , null: false
      t.float   :day_record                                     , null: false
      t.belongs_to :user                                        , null: false
      t.timestamps
     

    end
  end
end
