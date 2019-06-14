object @slide

attributes :id, :slide_name, :link_url, :published, :position, :product_id

node(:image_url) { |s| !s.slide_image.nil? ? s.slide_image.url : '' }

child taxon: :taxon do
  extends "spree/api/v1/taxons/show"
end
