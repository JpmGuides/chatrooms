class ConversationController < ActionController::Base
    def create
        Conversation.create(name: params[:name])
        redirect_to '/'
    end

    def show
        begin
            conversation = Conversation.find(params[:id])
        rescue ActiveRecord::RecordNotFound
            redirect_back(fallback_location: '/')
        else
            render :show, locals: { conversation: conversation }
        end
        
    end
end