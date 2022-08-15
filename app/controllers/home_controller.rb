class HomeController < ActionController::Base
    layout "application"
    def index
        unless session[:user_id] && User.find_by_id(session[:user_id])
            redirect_to '/login'
            return
        end
        
        user = User.find(session[:user_id])
        conversations = Conversation.order(:name)

        render :index, locals: { user: user, conversations: conversations }
    end
end