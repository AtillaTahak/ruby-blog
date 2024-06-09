class Article < ApplicationRecord
	belongs_to :user
	has_many :likes, dependent: :destroy
	has_many :likers, through: :likes, source: :user
	has_many :comments, dependent: :destroy

	has_many :article_tags, dependent: :destroy
	has_many :tags, through: :article_tags

	validates :title, presence: true, length: { maximum: 140 }

	has_rich_text :content
	before_save :set_default_content

	def tags_list
	  tags.map(&:name).join(', ')
	end

	def tags_list=(names)
	  self.tags = names.split(',').map do |name|
		Tag.find_or_create_by(name: name.strip)
	  end
	end

	def add_tag_by_name(tag_name)
	  tag = Tag.find_or_create_by(name: tag_name)
	  tags << tag unless tags.include?(tag)
	end

	def remove_tag(tag_name)
	  tags.where(name: tag_name).destroy_all
	end

  private

	def set_default_content
	  self.content ||= "content will be here"
	end
  end
