class ChecklistItemAnswer < ActiveRecord::Base
  belongs_to :checklist_item, inverse_of: :answers

  validates :checklist_item, :val, presence: true
  validates :prior, numericality: { only_integer: true }

  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
