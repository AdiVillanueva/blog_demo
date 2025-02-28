class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :customer

  validates :content, presence: true, length: { minimum: 1, maximum: 250, message: "cannot exceed 255 characters"  }
end
