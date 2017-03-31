class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :checklists, inverse_of: :user, dependent: :destroy

  has_many :checklists_visits, class_name: 'UsersChecklistsVisit',
                               inverse_of: :user,
                               dependent: :destroy

  mount_uploader :avatar, UserAvatarUploader

  attr_accessor :make_user_confirmed

  after_save :just_confirm_this_user, if: 'make_user_confirmed == "1"'

  validates :name, presence: true

  scope :ordered, -> { order(name: :asc, id: :asc) }

  private

  def just_confirm_this_user
    unless confirmed?
      self.confirmation_sent_at = Time.now if confirmation_period_expired?
      confirm
    end
  end
end
