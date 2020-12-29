json.extract! text, :id, :content, :user_id, :post_id, :name, :created_at, :updated_at
json.url text_url(text, format: :json)
