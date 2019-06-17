class Spree::Slide < ActiveRecord::Base

  has_and_belongs_to_many :slide_locations,
                          class_name: 'Spree::SlideLocation',
                          join_table: 'spree_slide_slide_locations'

  has_attached_file :image,
                    url: '/spree/slides/:id/:style/:basename.:extension',
                    path: ':rails_root/public/spree/slides/:id/:style/:basename.:extension',
                    convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validate :product_xor_taxon

  scope :published, -> { where(published: true).order('position ASC') }
  scope :location, -> (location) { joins(:slide_locations).where('spree_slide_locations.name = ?', location) }

  belongs_to :product, touch: true
  belongs_to :taxon, touch: true

  def initialize(attrs = nil)
    attrs ||= { published: true }
    super
  end

  def slide_name
    if (name.blank?)
      product.present? ? product.name : taxon.present? ? taxon.name : name
    else
      name
    end
  end

  def slide_link
    link_url.blank? && product.present? ? product : link_url
  end

  def slide_image
    !image.file? && product.present? && product.images.any? ? product.images.first.attachment : image
  end

  def product_xor_taxon
    if (!product.nil? || !taxon.nil?)
      # if either one is populated, ensure ONLY ony is populated
      errors.add(:base, "Slides cannot be linked to both products and taxons. Please choose only one.") unless product.blank? ^ taxon.blank?
    end
  end
end
