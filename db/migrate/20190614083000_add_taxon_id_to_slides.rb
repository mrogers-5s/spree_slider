class AddTaxonIdToSlides < ActiveRecord::Migration
  def change
    add_reference :spree_slides, :taxon, null: true
  end
end
