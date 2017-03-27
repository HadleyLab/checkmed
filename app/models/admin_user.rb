class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :recoverable, :trackable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  validates :name, presence: true

  def display_name
    name.present? ? name : email
  end
end
