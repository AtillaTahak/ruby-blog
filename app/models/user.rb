class User < ApplicationRecord
	has_many :likes
	has_many :liked_articles, through: :likes, source: :article
	has_many :comments
	has_many :articles

	devise :database_authenticatable, :registerable,
		   :recoverable, :rememberable, :validatable

	validates :nickname, uniqueness: true, presence: true

	before_validation :set_nickname, on: :create

	private

	def set_nickname
	  self.nickname = email.split('@').first if nickname.blank?
	end
  end
