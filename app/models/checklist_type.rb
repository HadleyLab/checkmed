class ChecklistType < ActiveRecord::Base
  has_many :checklists, inverse_of: :checklist_type,
                        dependent: :restrict_with_exception

  validates :name, presence: true
  validates :prior, numericality: { only_integer: true }

  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
