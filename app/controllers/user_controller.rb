class UserController < ActionController::Base
    def show_login
        render :login
    end

    def login
        user = User.find_by(name: params[:name])
        if user
            session[:user_id] = user.id
            redirect_to '/'
        else
            user = User.create(name: params[:name])
            session[:user_id] = user.id
            redirect_to '/'
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to '/'
    end
end