json.extract! post, :id, :user_id, :name, :thumbnail, :price, :introduction, :created_at, :updated_at
json.url post_url(post, format: :json)
