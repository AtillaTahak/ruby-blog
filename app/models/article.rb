class Article < ApplicationRecord
	enum status: { draft: 0, published: 1, archived: 2 }, _default: 'draft'

	validates :title, presence: true, length: { maximum: 140 }
	validates :content, presence: true, _default: 'Content will be here.'
end
