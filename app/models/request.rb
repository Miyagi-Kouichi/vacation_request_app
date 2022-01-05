class Request < ApplicationRecord
     belongs_to :user
     belongs_to :holiday

     def repuested_by?(user)
          requests.where(user_id: user.id).exists?
     end
end
