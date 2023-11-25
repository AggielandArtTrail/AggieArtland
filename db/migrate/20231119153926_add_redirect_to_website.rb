class AddRedirectToWebsite < ActiveRecord::Migration[7.0]
  def change
    add_column :art_pieces, :website_link, :string
  end
end
