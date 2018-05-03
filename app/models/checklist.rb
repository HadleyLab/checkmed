class Checklist < ActiveRecord::Base
  belongs_to :user, inverse_of: :checklists, counter_cache: true
  belongs_to :executor_role, inverse_of: :checklists
  belongs_to :speciality, inverse_of: :checklists

  has_many :groups, class_name: 'ChecklistGroup',
                    inverse_of: :checklist,
                    dependent: :destroy
  accepts_nested_attributes_for :groups,
                                allow_destroy: true,
                                reject_if: :all_blank

  # has_many :items, class_name: 'ChecklistItem',
  #                  inverse_of: :checklist,
  #                  dependent: :destroy

  has_many :users_visits, class_name: 'UsersChecklistsVisit',
                          inverse_of: :checklist,
                          dependent: :destroy

  validates :name, :user, :executor_role, presence: true
  validates :prior, numericality: { only_integer: true }
  validates_associated :groups

  scope :published, -> (status) { where(published: status) }
  scope :visibles, -> { where(hided: false).where(published: true) }
  scope :ordered, -> { order(prior: :asc, id: :asc) }
  scope :for_news, -> { order(created_at: :desc, id: :desc) }
  scope :best, -> { where.not(likes_count: 0).order(likes_count: :desc, id: :asc) }

  def increase_likes_count
    self.likes_count = likes_count + 1
    self.save
  end

  def decrease_likes_count
    self.likes_count = likes_count - 1
    self.save
  end

  def increase_views_count
    self.views_count = views_count + 1
    self.save
  end

end
