class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :article

	scope :approved, -> { where(approved: true) }
	scope :pending, -> { where(approved: false) }

	before_validation :set_false, on: :create

	private

	def set_false
	  self.approved = false
	end

end
