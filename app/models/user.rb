class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :checklists, inverse_of: :user, dependent: :destroy

  mount_uploader :avatar, UserAvatarUploader

  validates :name, presence: true

  scope :ordered, -> { order(name: :asc, id: :asc) }
end
