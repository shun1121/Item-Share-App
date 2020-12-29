class Post < ApplicationRecord
    mount_uploader :thumbnail, PictureUploader
    belongs_to :user
    has_many :texts
end
