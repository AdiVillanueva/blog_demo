class AddCustomerToPosts < ActiveRecord::Migration[8.0]
  def change
    add_reference :posts, :customer, null: false, foreign_key: true
  end
end
