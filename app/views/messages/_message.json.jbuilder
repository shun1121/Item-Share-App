json.extract! message, :id, :content, :user_id, :post_id, :created_at, :updated_at
json.url message_url(message, format: :json)
