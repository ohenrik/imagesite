class Page < ActiveRecord::Base

  validates :name, :status, presence: true
  belongs_to :photo
  has_many :menu_items, :as => :menuable, :dependent => :destroy
  has_one :user, :as => :home

  # This page is a sub_item under these pages
  has_many :sub_items, :as => :pageable, :class_name => "PageItem", :dependent => :destroy

  # This page has these sub_items as its page items.
  has_many :page_items, :foreign_key => "page_id", :dependent => :destroy
  
  belongs_to :layout, :foreign_key => "layout_id" , :class_name => "CodeFile"
  belongs_to :template, :foreign_key => "template_id" , :class_name => "CodeFile"

  accepts_nested_attributes_for :page_items, allow_destroy: true

  # Liquid methods
  liquid_methods :thumbnail, :name, :content, :excerpt, :link, :items


  #def layout_id
  # read_attribute(:layout_id).presence || current_tenant.theme.code_files.where(:hierarchy => 'layout').first
  #end

  #def template_id
  # read_attribute(:template_id).presence || current_tenant.theme.code_files.where(:hierarchy => 'template').first
  #end

  def link
    "/pages/#{id}"
  end

  def thumbnail
    if photo.nil?
      "/assets/default/large_thumb_no-thumb.png"
    else
      photo.image_url(:large_thumb)
    end
  end

  def items
    page_items.arrange(order: :position)
  end

end
