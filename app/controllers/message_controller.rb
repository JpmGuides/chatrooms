class MessageController < ApplicationController

  def create
    # reject if user is not logged in
    unless session[:user_id]
      redirect_to :back, flash: { error: "You must be logged in to post a message." }, status: :unauthorized
      return
    end

    conversation = Conversation.find(params[:conversation_id])
    paricipant = conversation
                      .participants
                      .where(user_id: session[:user_id])
                      .first_or_create(user_id: session[:user_id])

    
    message = conversation.messages.create(body: params[:message], author_id: paricipant.id)

    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message: message.body, author: message.author.name

    redirect_to conversation_path(conversation)
  end
end
