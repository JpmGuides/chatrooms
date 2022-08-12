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
    media = Media.create(message_id: message.id,conversation_id: conversation.id) 
    media.file.attach(params[:file]) if params[:file]
    media.save
    
    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message: message.body, author: message.author.name
    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message: Rails.application.routes.url_helpers.rails_blob_path(message.media.file, only_path: true), author: "system" if params[:file]
  end
end
