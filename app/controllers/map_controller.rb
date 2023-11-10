class MapController < ApplicationController
    def show
        @art_pieces = ArtPiece.all
    end

    def updateloc
        # puts "received location"
        # puts params[:latitude]
        # puts params[:longitude]
        # puts params[:accuracy]

        session[:latitude] = params[:latitude]
        session[:longitude] = params[:longitude]
        session[:accuracy] = params[:accuracy]

        respond_to do |format|
            format.json { head :no_content }
        end
    end 
end