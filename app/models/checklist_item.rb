class ChecklistItem < ActiveRecord::Base
  # belongs_to :checklist, inverse_of: :items
  belongs_to :group, class_name: 'ChecklistGroup', inverse_of: :items

  has_many :answers, class_name: 'ChecklistItemAnswer',
                     inverse_of: :checklist_item,
                     dependent: :destroy
  accepts_nested_attributes_for :answers,
                                allow_destroy: true,
                                reject_if: :all_blank

  mount_uploader :picture, ChecklistItemPictureUploader

  # validates :title, presence: true, unless: -> (item) { item.picture.present? }
  # validates :picture, presence: true, unless: -> (item) { item.title.present? }
  validates :group, presence: true
  validates :prior, numericality: { only_integer: true }
  validates_associated :answers

  after_save :check_title_and_picture

  scope :ordered, -> { order(prior: :asc, id: :asc) }

  def check_title_and_picture
    self.destroy if self.title.empty? && self.picture.blank?
  end
end
