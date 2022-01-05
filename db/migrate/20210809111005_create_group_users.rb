class CreateGroupUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_users do |t|
      t.belongs_to :group
      t.belongs_to :user
      t.timestamps
    end 
  end
end
