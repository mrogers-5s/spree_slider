object @slide_location

attributes :id, :name

child slides: :slides do
  extends "spree/api/v1/slides/show"
end
