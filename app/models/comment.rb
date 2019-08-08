class Comment < ApplicationRecord
	belongs_to :user, class_name: "User"
	belongs_to :micropost
	validates :comment,  presence: true
	validates :user_id,  presence: true
	validates :micropost_id,  presence: true
end
