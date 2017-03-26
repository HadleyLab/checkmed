class UsersChecklistsVisit < ActiveRecord::Base
  belongs_to :user, inverse_of: :checklists_visits
  belongs_to :checklist, inverse_of: :users_visits

  validates :user, :checklist, presence: true
end
