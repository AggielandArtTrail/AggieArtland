class ArtPiece < ApplicationRecord
    has_one_attached :photo
    validates_presence_of :name, :address
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
    validates_presence_of :geocode

    def get_icon
        if self.photo.attached?
            # self.photo
            Rails.application.routes.url_helpers.rails_blob_url(self.photo, only_path: true)
        else
            'https://aggie-art-public.s3.us-east-2.amazonaws.com/default_art.png'
        end
    end

    def distance_to(target_lat, target_lon)
        # haversine formula for latlon distance calc
        # http://www.movable-type.co.uk/scripts/latlong.html
        lat1 = self.latitude
        lon1 = self.longitude
        
        lat2 = target_lat
        lon2 = target_lon

        radius = 6371e3; # metres
        p1 = lat1 * Math::PI/180 # φ, λ in radians
        p2 = lat2 * Math::PI/180
        dP = (lat2-lat1) * Math::PI/180
        dL = (lon2-lon1) * Math::PI/180

        a = Math.sin(dP/2) * Math.sin(dP/2) +
            Math.cos(p1) * Math.cos(p2) *
            Math.sin(dL/2) * Math.sin(dL/2)
        c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))

        d = radius * c # in metres
        d_miles = d * 0.000621371 # in miles

        return d_miles
    end

    def distance_to_pretty(target_lat, target_lon)
        dist = self.distance_to(target_lat, target_lon)
        s = '%.2f miles' % dist
        if dist < 1
            s += ' (%.0f ft)' % (dist * 5280)
        end
        s
    end

    def format_location(lat, lon)
        n = lat >= 0 ? (('%.3f' % lat) + "°N") : (('%.3f' % -lat) + "°S")
        e = lon >= 0 ? (('%.3f' % lon) + "°E") : (('%.3f' % -lon) + "°W")
        n + " " + e
    end

end
