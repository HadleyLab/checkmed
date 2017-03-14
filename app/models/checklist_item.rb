class ChecklistItem < ActiveRecord::Base
  belongs_to :checklist, inverse_of: :items

  validates :title, :sb_group, presence: true
  validates :sb_group, inclusion: { in: (1..5) }
  validates :prior, numericality: { only_integer: true }

  scope :ordered, -> { order(sb_group: :asc, prior: :asc, id: :asc) }
end
