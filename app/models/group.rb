class Group < ApplicationRecord
     has_many :group_users
     has_many :notifications
     has_many :users, through: :group_users
     # has_many :users, through: :notifications
     validates :group_name, presence: true, uniqueness: true


     has_many :group_holidays, through: :users, source: :holiday 

     def yes_no?
          requests.where(yes_no: "no").exists?
     end
end
