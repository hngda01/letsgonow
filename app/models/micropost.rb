class Micropost < ApplicationRecord
  
  belongs_to :user
  belongs_to :district
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
  validates :district_id, presence: true
  validate  :picture_size
  before_save :fix_title

  has_many :comments,  dependent: :destroy
  has_many :likes,  dependent: :destroy
  has_many :save_posts,  dependent: :destroy
  has_many :notifications,  dependent: :destroy
  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    def fix_title
      title = self.title
      len= title.length - 1
      res1=''
      start = 0
      if title[0]== ' '
      
      for i in 1..len
        if title[i] != ' '
          title = title[i..len] 
          break
        end
      end
      end
      self.title = title[start..len].capitalize
    end
  end