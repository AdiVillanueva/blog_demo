json.extract! post, :id, :title, :content, :active, :featured, :publication_date, :created_at, :updated_at
json.url post_url(post, format: :json)
