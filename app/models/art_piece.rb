class ArtPiece < ApplicationRecord
    validates_presence_of :name, :address
    geocoded_by :address
    after_validation :geocode, if: :address_changed?

    def has_icon?
        File.exist?(Rails.root.join('app', 'assets', 'images', icon_name))
    end

    def icon_name
        'art_piece_icon_' + id.to_s + '.png'
    end

end
