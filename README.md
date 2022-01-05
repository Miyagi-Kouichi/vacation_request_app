# README


## user テーブル

| Column             | Type    | Options                      |
| --------           | ------  | -----------                  |
| user_name          | string  | null: false                  |
| email              | string  | null: false ,unique: true    |
| encrypted_password | string  | null: false                  |
| Position           | string  | null: false                  |

<!-- position にActiveHashを使う。 -->
### Association
- has_many :request
- has_many :group



## request テーブル

| Column              | Type   | Options                      |
| --------            | ------ | -----------                  |
| leader_mark         | string | null: false                  |
| director_mark       | string | null: false                  |
| general_affair_mark | string | null: false                  |

### Association
- belongs_to :user



## holiday

      t.date    :application_date                               , null: false
      t.time    :holiday_time_start                               
      t.time    :holiday_time_end                                 
      t.integer :acquisition_time                            
      t.string  :acquisition_days                               , null: false
      t.string  :reason                                         , null: false  
      t.integer :time_record                                    , null: false
      t.float   :day_record                                     , null: false
      t.belongs_to :user                                        , null: false


### Association
- belongs_to :grouping


   ## remaining_holidays 
   
    t.integer    :last_year_days                        , null: false
    t.integer    :last_year_time                        , null: false
    t.integer    :this_year_days                        , null: false
    t.float      :total_days                            , null: false
    t.integer    :total_time                            , null: false
    t.string     :working_hours                         , null: false
    t.references :user, foreign_key: true               , null: false
    t.float      :changeable_days                       
    t.integer    :changeable_time       
    t.integer    :time_limit
    t.timestamps

    # 有効期間
    t.date      :effective_period_start
    t.date      :effective_period_end
    # 備考
    t.string    :reason 
    # 入社年月日
    t.date      :joining_date    


## group
| Column      | Type   | Options                      |
| --------    | ------ | -----------                  |
| group_name  | string | Options                      |



### Association
- belongs_to :grouping



## group テーブル （中間テーブル）

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| group  | references | null: false, foreign_key: true  |

### Association
- belongs_to :group
- belongs_to :user
