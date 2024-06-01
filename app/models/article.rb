class Article < ApplicationRecord
	validates :title, presence: true, length: { maximum: 140 }

	has_rich_text :content
	before_save :set_default_content

    private

    def set_default_content
        self.content ||= "content will be here"
    end
  end
