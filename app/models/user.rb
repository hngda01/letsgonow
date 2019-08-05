class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  before_save :fix_name
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email,  presence: true
  mount_uploader :picture
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :save_posts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
  foreign_key: "follower_id",
  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower



  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
   return false if remember_digest.nil?

   BCrypt::Password.new(remember_digest).is_password?(remember_token)
 end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  def feed
    following_ids = "SELECT followed_id FROM relationships
    WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
     OR user_id = :user_id", user_id: id)
  end
  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
  private
  def fix_name    
    len= name.length - 1
    res1=''
    start = 0
    #loai bo dau cach
    if name[0]== ' '
      start = -1
    end
    for i in 1..len
      if name[i] != ' '
        if start == -1
          start = i
        end    
        if i < len && name[i+1] != ' '
          name[i+1] = name[i+1].mb_chars.downcase
        end      
      end 
      if name[i] == ' ' && i < len && name[i+1] != ' '
          name[i+1] = name[i+1].mb_chars.upcase
      end     
    end
    self.name = name[start..len]

  end

end