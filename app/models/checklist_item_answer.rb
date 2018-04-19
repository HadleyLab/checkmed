class ChecklistItemAnswer < ActiveRecord::Base
  belongs_to :checklist_item, inverse_of: :answers

  validates :checklist_item, presence: true
  validates :prior, numericality: { only_integer: true }

  after_save :check_empty_values

  scope :ordered, -> { order(prior: :asc, id: :asc) }

  def check_empty_values
    self.destroy if self.val.to_s.empty?
  end
end
