class Photo < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	validates :image, :name, presence: true

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	belongs_to :user
	has_many :sub_items, :as => :pageable, :class_name => "PageItem", :dependent => :destroy


	# Liquid methods
	liquid_methods :name, :index, :tags, :link, :large, :medium, :small, :thumbnail, :large_thumbnail, :medium_thumbnail, :photo_tags

	def thumbnail
		image_url(:small_thumb)
	end

	def medium_thumbnail
		image_url(:medium_thumb)
	end

	def large_thumbnail
		image_url(:large_thumb)
	end

	def small
		image_url(:small)
	end

	def medium
		image_url(:medium)
	end

	def large
		self.image_url(:large)
	end

	def photo_tags
		tags
	end

	def tag_to_list
		tag_list
	end

	def link
		"/photos/#{id}"
	end

	def action?
		params[:action]
	end

	def params?
		params[:action]
	end




	def self.tagged_with(name)
		Tag.find_by_name(name).photos
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:name)
	end

	def edit_tag_list
		tags.map(&:name).join(", ")
	end

	def edit_tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip).first_or_create!
		end
	end

end
