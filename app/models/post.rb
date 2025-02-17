class Post < ApplicationRecord
  include Filterable
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5, maximum: 255, message: "cannot exceed 255 characters" }, uniqueness: { case_sensitive: true }
  validates :content, presence: true, length: { minimum: 5, maximum: 1500, message: "cannot exceed 1500 characters" }

  audited associated_with: :user

  scope :for_datatables, -> {
    select(%(
      id,
      title,
      content,
      active,
      featured,
      publication_date,
      created_at,
      updated_at
    )).order(created_at: :desc)
  }

  scope :filter_by_title, ->(title) {
    where("title ILIKE ?", "%#{title}%")
  }

  scope :filter_by_status, ->(status) {
    where("active = ?", status)
  }
end
