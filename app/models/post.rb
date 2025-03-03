class Post < ApplicationRecord
  include Filterable
  belongs_to :customer
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5, maximum: 255, message: "cannot exceed 255 characters" }, uniqueness: { case_sensitive: true }
  validates :content, presence: true, length: { minimum: 5, maximum: 1500, message: "cannot exceed 1500 characters" }

  audited associated_with: :customer

  scope :for_datatables, -> {
      select(%(
        id,
        title,
        content,
        active,
        featured,
        publication_date,
        created_at,
        updated_at,
        customer_id
      )).order(created_at: :desc)
    }

    scope :filter_by_title, ->(title) {
      where("title ILIKE ?", "%#{title}%")
    }

    scope :filter_by_active, ->(status) {
      where("active = ?", status)
    }

    scope :filter_by_featured, ->(status) {
      where("featured = ?", status)
    }

    scope :filter_order_by, ->(order_by_vals) {
      return unless order_by_vals.present? && order_by_vals.length == 2

      column, direction = order_by_vals
      direction = %w[asc, desc].include?(direction) ? direction: "asc"
      order ("#{column} #{direction}")
    }

  def like_toggle(customer)
    if liked?(customer)
      likes.find_by(customer: customer).destroy
    else
      likes.create(customer: customer)
    end
    update(likes_count: likes.count)
  end

  def liked?(customer)
    likes.exists?(customer: customer)
  end
end
