class ConversationController < ActionController::Base
    layout "application"
    def create
        # reject if user is not logged in
        unless session[:user_id]
            redirect_back flash: { error: "You must be logged in to create a conversation." }, status: :unauthorized, fallback_location: '/'
            return
        end

        Conversation.create(name: params[:name])
        redirect_to '/'
    end

    def show
        # check if user is logged in
        unless session[:user_id]
            redirect_to '/login'
            return
        end

        conversation = Conversation.find(params[:id])

        render :show, locals: { conversation: conversation, page_title: conversation.name }
        
    rescue ActiveRecord::RecordNotFound
        redirect_back(fallback_location: '/')
        return

    end
end