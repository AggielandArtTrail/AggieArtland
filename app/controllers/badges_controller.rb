class BadgesController < ApplicationController
  before_action :set_badge, only: %i[ show edit update destroy ]

  # GET /badges or /badges.json
  def index
    @badges = Badge.all
  end

  # GET /badges/1 or /badges/1.json
  def show
    @badge = Badge.find_by(id: params[:id])
  end

  # GET /badges/new
  def new
    @badge = Badge.new
  end

  # GET /badges/1/edit
  def edit
    # badge = Badge.find_by(id: params[:id])
    
    # user_id = session[:user_id]
    # user = User.find_by(id: user_id)
    
    # if user == nil 
    #   flash[:notice] = 'You must be logged in to access this section.'
    #   redirect_to login_path
    # elsif !user.is_admin?
    #   flash[:notice] = 'You do not have the required permissions to edit Badges.'
    #   redirect_to show_badge_path(badge)
    # end
  end

  def remove_custom_icon
    badge = Badge.find_by(id: params[:id])
    badge.remove_custom_icon
    redirect_to badge
  end

  # POST /badges or /badges.json
  def create
    @badge = Badge.new(badge_params)

    respond_to do |format|
      if @badge.save
        format.html { redirect_to badge_url(@badge), notice: "Badge was successfully created." }
        format.json { render :show, status: :created, location: @badge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /badges/1 or /badges/1.json
  def update
    respond_to do |format|
      if @badge.update(badge_params)
        format.html { redirect_to badge_url(@badge), notice: "Badge was successfully updated." }
        format.json { render :show, status: :ok, location: @badge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1 or /badges/1.json
  def destroy
    @badge.destroy

    respond_to do |format|
      format.html { redirect_to badges_url, notice: "Badge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge
      @badge = Badge.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def badge_params
      params.require(:badge).permit(:name, :description, :badge_type, :requirement, :photo)
    end
end
