class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :comment_content  , null: false
      # t.belongs_to :user
      # t.belongs_to :holiday
      t.references :user, foreign_key: true  
      t.references :holiday, foreign_key: true  


      t.timestamps
    end
  end
end
