class Song < ApplicationRecord
  validates :title, length: { minimum: 1 }, presence: true

  belongs_to :user
end
