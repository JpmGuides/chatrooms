class HomeController < ActionController::Base
    def index
        if session[:user_id]
            user = User.find(session[:user_id])
            conversations = Conversation.order(:name)


            render :index, locals: { user: user, conversations: conversations }
        else
            redirect_to '/login'
        end
    end
end