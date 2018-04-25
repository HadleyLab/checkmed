class Like < ActiveRecord::Base
  belongs_to :liker, class_name: 'User'
  belongs_to :likable, class_name: 'Checklist'

  validates :liker_id, :likable_id, presence: true

end
