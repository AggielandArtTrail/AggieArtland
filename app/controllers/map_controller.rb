class MapController < ApplicationController
    def show
    @art_pieces = ArtPiece.all
    
    end
end