class PasswordResetsController < ApplicationController
    def forgot
        if params[:email].blank? # check if email is present
          return render json: {error: 'Email not present'}, status: :bad_request
        end
    
        user = User.find_by(email: params[:email]) # if present find user by email
    
        if user.present?
          #user.generate_password_token! #generate pass token
          UserMailer.forgot_password(user).deliver_now
          render json: {status: 'ok'}, status: :ok
          flash[:notice] = "Check your inbox for reset password!"
        else
          render json: {error: ['Email address not found. Please check and try again.']}, status: :not_found
        end
    end

    def edit
        @user = User.find_signed(params[:token], purpose: "password_reset")
    rescue
        redirect_to login_path, notice: "Your token has expired, please try again."
    end
    
    def reset
        @user = User.find_signed(params[:token], purpose: "password_reset")
        
        if @user.update(password_params)
            redirect_to login_path, notice: "Password has been reset!"
        else
            redirect_to password_reset_edit_path, notice: @user.errors.full_messages.first
        end
    end

    def password_params
        params.require(:user).permit(:password,:password_confirmation)
    end
  
end