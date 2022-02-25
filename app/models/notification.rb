class Notification < ApplicationRecord
#      belongs_to :receiver, class_name: "User"
#      belongs_to :sender,   class_name: "User"
     belongs_to :group, dependent: :destroy
     belongs_to :user
end
