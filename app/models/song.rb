class Song < ApplicationRecord
  validates :title, length: { minimum: 1 }, presence: true

  belongs_to :user

  def self.filter(current_user)
    where(user_id: current_user.id)
  end
end
