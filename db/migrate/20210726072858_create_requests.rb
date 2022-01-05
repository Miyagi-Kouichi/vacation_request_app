class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t| 
      t.references :user,    foreign_key: true             , null: false  
      t.references :holiday, foreign_key: true             , null: false  
      t.string  :position                                  , null: false 
      t.string  :yes_no                                    , null: false                           
      t.timestamps
    end
  end
end
