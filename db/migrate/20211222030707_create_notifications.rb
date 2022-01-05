class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      # t.references :receiver, foreign_key: { to_table: :user }
      t.belongs_to :user
      t.belongs_to :group
      # t.references :sender, foreign_key: { to_table: :uesr }
    end
  end
end
