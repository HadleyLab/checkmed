class ChecklistGroup < ActiveRecord::Base
  belongs_to :checklist, inverse_of: :groups

  has_many :items, class_name: 'ChecklistItem',
                   inverse_of: :group,
                   foreign_key: 'group_id',
                   dependent: :destroy
  accepts_nested_attributes_for :items,
                                allow_destroy: true,
                                reject_if: :all_blank

  validates :checklist, :name, presence: true
  validates :prior, numericality: { only_integer: true }
  validates_associated :items

  scope :ordered, -> { order(prior: :asc, id: :asc) }
end
