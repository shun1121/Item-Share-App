class Profile < ApplicationRecord
    mount_uploader :thumbnail, PictureUploader
    belongs_to :user
end
