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

        begin
            conversation = Conversation.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_back(fallback_location: '/')
            return
        end

        render :show, locals: { conversation: conversation, page_title: conversation.name }
    end
end