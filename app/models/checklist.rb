class Checklist < ActiveRecord::Base
  belongs_to :user, inverse_of: :checklists
  belongs_to :executor_role, inverse_of: :checklists

  validates :name, :user, :executor_role, presence: true
  validates :treat_stage, inclusion: { in: (1..5) }, allow_nil: true
  validates :prior, numericality: { only_integer: true }

  scope :visibles, -> { where(hided: false) }
  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
