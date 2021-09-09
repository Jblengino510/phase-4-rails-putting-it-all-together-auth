class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: { errors: ["Username and/or password invalid"] }, status: :unauthorized
        end
    end

    def destroy
        if session.include? :user_id
            session.delete :user_id
            head :no_content
        else
            render json: { errors: ["User is not logged in"] }, status: :unauthorized
        end
    end
end
