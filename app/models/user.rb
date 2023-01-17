class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accepted_received_follow_requests, -> { accepted }, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :accepted_sent_follow_requests, -> { accepted }, class_name: "FollowRequest", foreign_key: :sender_id
  has_many :comments, foreign_key: :author_id
  has_many :discover, through: :leaders, source: :liked_photos
  has_many :feed, through: :leaders, source: :own_photos
  has_many :followers, through: :accepted_received_follow_requests, source: :sender
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient
  has_many :liked_photos, through: :likes, source: :photo
  has_many :likes, foreign_key: :fan_id
  has_many :own_photos, class_name: "Photo", foreign_key: :owner_id
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: :sender_id

  validates :username, presence: true, uniqueness: { case_sensitive: false }

end
