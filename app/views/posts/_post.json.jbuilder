json.extract! post, :id, :content, :expire, :seen, :created_at, :updated_at
json.url post_url(post, format: :json)
