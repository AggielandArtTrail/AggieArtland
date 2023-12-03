class UsersController < ApplicationController
  include ApplicationHelper
  before_action :require_login, only: [:show,:edit,:update]
  before_action :require_admin, only: [:admin_panel, :toggle_admin]
  before_action :authenticate_user, only: [:show,:edit,:update]

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        UserMailer.welcome_email(user_params[:email]).deliver_now
        session[:user_id] = @user.id
        redirect_to '/map', notice: 'User successfully created!'
      else
        redirect_to signup_path, notice: @user.errors.full_messages.first
      end
    end

    def show

    end

    def edit

    end

    def update
        if @user.update_column(:name,user_params[:name] )
            redirect_to edit_user_path, notice: "Name has been changed."
        else
          redirect_to edit_user_path, notice: "Name could not be changed."
        end
    end

    def stamps
      @user = User.find(params[:id])
      stamps_users = UserStamps.find_by_user_id(params[:id])
      @art_piece_ids = stamps_users.pluck(:art_pieces_id)
      puts @art_piece_ids
      render :stamps
    end

    def clear_badges
      current_user.clear_badges()
      flash[:notice] = 'Badge collection reset successfully.'
      redirect_to badges_path(current_user)
    end

    def clear_stamps
      current_user.clear_stamps()
      UserStamps.where(users_id:current_user.id).destroy_all
      flash[:notice] = 'Stamp collection reset successfully.'
      redirect_to stamps_path(current_user)
    end
    
    def admin_panel
      @users = User.all
      @stamps_users = UserStamps.find_recordy_by_time(1)
      @stamps_users_day = UserStamps.find_recordy_by_day(1)
      @stamps_users_week = UserStamps.find_recordy_by_day(1)
      if params[:search].present?
        @users = @users.where("email LIKE ? OR name LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
      end
    end    

    def toggle_admin
      @user = User.find(params[:user_id])
      current_user = User.find(session[:user_id]) 

      if current_user.is_admin? && @user != current_user 
        if @user.user_type == "admin"
          @user.update_column(:user_type, nil)
          notice = 'Admin access revoked successfully'
        else
          @user.update_column(:user_type, "admin")
          notice = 'User added as admin successfully'
        end
      else
        notice = 'You do not have permission to perform this action'
      end
    
      redirect_to admin_panel_users_path, notice: notice
    end

    def engagement_tracking
      time = params[:time]
      @stamps_users = UserStamps.find_recordy_by_time(time)
      render :engagement_tracking
    end
    
    
    private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def require_login
      unless logged_in?
        flash[:error] = 'You must be logged in to access this section.'
        redirect_to login_path
      end
    end

    def require_admin
      unless current_user.is_admin?
        flash[:error] = 'You must be an admin to access this section.'
        redirect_to root_path
      end
    end

    def authenticate_user
      # Implement your authentication logic here
      if session[:user_id] == (params[:id])
        @user = User.find(params[:id])
      else
        @user = User.find(session[:user_id])
      end
    end
  end