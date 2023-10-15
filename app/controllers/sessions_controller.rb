class SessionsController < ApplicationController
    def create
        @user = User.find_by(email: params[:session][:email])
        puts " THe user is"
        puts @user
        if !!@user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            puts "Inside If blocj"
            redirect_to '/map', notice: 'User successfully Logged in!'
        else
            redirect_to login_path , notice: "Incorrect email or password"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: 'You have been logged out.'
    end
end