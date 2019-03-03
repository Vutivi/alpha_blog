class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :username, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            length: { minimum:10, maximum: 105 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 6, maximum: 270}
  has_secure_password

  # Follows a blogger.
 def follow(other_user)
   following << other_user
 end

 # Unfollows a blogger.
 def unfollow(other_user)
   following.delete(other_user)
 end

 # Returns true if the current user is following the other blogger.
 def following?(other_user)
   following.include?(other_user)
 end
end
