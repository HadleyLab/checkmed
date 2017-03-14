class Checklist < ActiveRecord::Base
  belongs_to :user, inverse_of: :checklists
  belongs_to :executor_role, inverse_of: :checklists

  has_many :items, class_name: 'ChecklistItem',
                   inverse_of: :checklist,
                   dependent: :destroy
  accepts_nested_attributes_for :items,
                                allow_destroy: true,
                                reject_if: :all_blank

  # Questions sublists:
  #   1 - Symptoms
  #   2 - Physical exams
  #   3 - Labs
  #   4 - Procedures
  #   5 - Medications
  #   0 - reserved for non-sublists questions


  validates :name, :user, :executor_role, presence: true
  validates :treat_stage, inclusion: { in: (1..5) }, allow_nil: true
  validates :prior, numericality: { only_integer: true }
  validates_associated :items

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
