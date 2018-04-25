class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :checklists, inverse_of: :user, dependent: :destroy

  has_many :checklists_visits, class_name: 'UsersChecklistsVisit',
                               inverse_of: :user,
                               dependent: :destroy

  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy

  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, class_name:  'Like',
                                 foreign_key: 'liker_id',
                                 dependent:   :destroy

  has_many :likables, through: :likes, source: :likable

  mount_uploader :avatar, UserAvatarUploader

  attr_accessor :make_user_confirmed

  after_save :just_confirm_this_user, if: 'make_user_confirmed == "1"'

  validates :name, presence: true

  scope :ordered, -> { order(name: :asc, id: :asc) }

  def like(checklist)
    likables << checklist
    checklist.increase_likes_count
  end

  def dislike(checklist)
    likables.delete(checklist)
    checklist.decrease_likes_count
  end

  def follow(other_user)
    following << other_user
    increase_followers_count(other_user)
    increase_followed_count(self)
  end

  def unfollow(other_user)
    following.delete(other_user)
    decrease_followers_count(other_user)
    decrease_followed_count(self)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def increase_followers_count(user)
    user.followers_count = user.followers_count + 1
    user.save
  end

  def decrease_followers_count(user)
    user.followers_count = user.followers_count - 1
    user.save
  end

  def increase_followed_count(user)
    user.followed_count = user.followed_count + 1
    user.save
  end

  def decrease_followed_count(user)
    user.followed_count = user.followed_count - 1
    user.save
  end

  def return_news
    checklists_arr = []
    self.following.map { |u| u.checklists.visibles.map { |ch| checklists_arr.push(ch.id) } }
    Checklist.where(id: checklists_arr).for_news
  end

  private

  def just_confirm_this_user
    unless confirmed?
      self.confirmation_sent_at = Time.now if confirmation_period_expired?
      confirm
    end
  end
end
