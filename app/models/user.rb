class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :requests
  has_many :holidays 
  has_one  :remaining_holiday
  has_many :comments
  has_many :Notifications
  has_many :WeekHolidayChanges
  has_many :week_h_checks
  # has_many :groups, through: :Notifications
  # PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  
  # with_options presence: true, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }, length: { minimum: 6 },
  #     confirmation: true do
  #   validates :password
  #   validates :password_confirmation
  # end

  with_options presence: true do
    validates :email
    validates :user_name
    validates :position
  end
end
