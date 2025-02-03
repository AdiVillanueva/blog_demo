class Post < ApplicationRecord
    belongs_to :user

    validates :title, presence: true, length: { minimum: 5, maximum: 255, message: "cannot exceed 255 characters" }, uniqueness: { case_sensitive: true }
    validates :content, presence: true, length: { minimum: 5, maximum: 1500, message: "cannot exceed 1500 characters" }

    audited associated_with: :user
end
