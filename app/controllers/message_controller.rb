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
    media_url = nil
    media_representable = false
    media_filename = nil

    if params[:file]
      media = Media.create(message_id: message.id,conversation_id: conversation.id)
      media.file.attach(params[:file]) 
      media.save
      media_url = rails_blob_path(message.media.file, only_path: true) 
      media_representable = media.file.representable?
      media_filename = media.file.filename
    end

    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message: message.body, author: message.author.name, media: {url: media_url, media_is_representable: media_representable, media_filename: media_filename}
  end
end
