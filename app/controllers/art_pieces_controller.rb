class ArtPiecesController < ApplicationController
  before_action :set_art_piece, only: %i[ show edit update destroy ]

  # GET /art_pieces or /art_pieces.json
  def index
    @art_pieces = ArtPiece.all
  end

  # GET /art_pieces/1 or /art_pieces/1.json
  def show
    @art_piece = ArtPiece.find_by(id: params[:id])
  end

  # GET /art_pieces/new
  def new
    @art_piece = ArtPiece.new
  end

  # GET /art_pieces/1/edit
  def edit
    # art_piece = ArtPiece.find_by(id: params[:id])
    
    # user_id = session[:user_id]
    # user = User.find_by(id: user_id)
    
    # if user == nil 
    #   flash[:notice] = 'You must be logged in to access this section.'
    #   redirect_to login_path
    # elsif !user.is_admin?
    #   flash[:notice] = 'You do not have the required permissions to edit art pieces.'
    #   redirect_to show_art_piece_path(art_piece)
    # end
  end

  # POST /art_pieces or /art_pieces.json
  def create
    @art_piece = ArtPiece.new(art_piece_params)

    respond_to do |format|
      if @art_piece.save
        format.html { redirect_to art_piece_url(@art_piece), notice: "Art piece was successfully created." }
        format.json { render :show, status: :created, location: @art_piece }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @art_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /art_pieces/1 or /art_pieces/1.json
  def update
    respond_to do |format|
      if @art_piece.update(art_piece_params)
        format.html { redirect_to art_piece_url(@art_piece), notice: "Art piece was successfully updated." }
        format.json { render :show, status: :ok, location: @art_piece }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @art_piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /art_pieces/1 or /art_pieces/1.json
  def destroy
    @art_piece.destroy

    respond_to do |format|
      format.html { redirect_to art_pieces_url, notice: "Art piece was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload_icon
    art_piece = ArtPiece.find_by(id: params[:id])
    icon = params[:picture]

    image = MiniMagick::Image.open(File.open(params[:picture].tempfile))
    image.resize "500x500"

    filename = 'art_piece_icon_' + art_piece.id.to_s + '.png'
    # folder = Rails.root.join('public', 'icons')
    folder = Rails.root.join('app', 'assets', 'images')
    FileUtils.mkdir_p(folder) unless File.exist?(folder)

    path = File.join folder, filename

    # File.open(path, 'wb') do |file|
    #   file.write(icon.read)
    # end
    image.write(path)

    flash[:notice] = 'Art piece icon successfully changed.'
    redirect_to show_art_piece_path(art_piece)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_art_piece
      @art_piece = ArtPiece.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def art_piece_params
      params.require(:art_piece).permit(:name, :description, :address, :latitude, :longitude,:artist)
    end
end
