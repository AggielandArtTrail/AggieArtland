json.extract! art_piece, :id, :name, :description, :address, :latitude, :longitude, :website_link, :created_at, :updated_at
json.url art_piece_url(art_piece, format: :json)
