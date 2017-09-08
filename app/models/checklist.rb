class Checklist < ActiveRecord::Base
  belongs_to :checklist_type, inverse_of: :checklists
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
  validates :treat_stage, numericality: { only_integer: true, greater_than: 0 },
                          allow_nil: true
  validates :prior, numericality: { only_integer: true }
  validates_associated :groups

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
