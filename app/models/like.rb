class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :post, counter_cache: true
end
