class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 5, maximum: 400 }

  has_many :comments
end
