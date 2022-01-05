class Holiday < ApplicationRecord
     belongs_to :user
     has_many :requests, dependent: :destroy
     has_many :comments, dependent: :destroy
   

     with_options presence: true do
          validates :application_date 
          validates :acquisition_days 
          validates :reason        
     end

     def repuested_by?(user)
          requests.where(user_id: user.id).exists?
     end

     def yes_no?
          requests.where(yes_no: "no").exists?
     end
end
