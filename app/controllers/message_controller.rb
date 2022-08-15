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

    message_body = nil
    medium_data=nil

    message_body = params[:message] if params[:message]
    
    message = conversation.messages.create(body: message_body, author_id: paricipant.id)
    
    if params[:file]
      medium_data = Array.new
      params[:file].each do |file|
        media = message.attach_media(file: file)
        medium_data.push({url: rails_blob_path(media.file, only_path: true), representable: media.file.representable?, filename: media.file.filename})
      end
    end

    ActionCable.server.broadcast "conversation_channel_#{conversation.id}", message: message.body, author: message.author.user.name, media: medium_data
  end

end


