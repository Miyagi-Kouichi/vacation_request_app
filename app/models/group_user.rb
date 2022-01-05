class GroupUser < ApplicationRecord
     # belongs_to :user, foreign_key: :user_id
     belongs_to :user
     # belongs_to :group, foreign_key: :group_id
     belongs_to :group

     validates :user_id, uniqueness: { scope: :group_id }

     # validates :user_id, uniqueness: { scope: :group_id}
end
