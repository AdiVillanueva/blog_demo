# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.find_or_create_by(email: "admin@gmail.com")
user.update!(
    password: "adminpass",
    password_confirmation: "adminpass",
    isAdmin: true
)

Post.destroy_all
ActiveRecord::Base.connection.execute("ALTER SEQUENCE posts_id_seq RESTART WITH 1;")
15.times do
  last_post = Post.last # Reload every time
  prefix = last_post.present? ? last_post.id + 1 : 1
  Post.create!(
    title: "Post #{prefix}",
    content: "Contents of Post #{prefix}",
    active: true,
    featured: false,
    user: User.first
  )
end
