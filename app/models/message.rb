class Message < ApplicationRecord

    belongs_to :author, class_name: 'Participant', foreign_key: 'author_id'
    belongs_to :conversation
    has_many :medium, class_name: 'Media'

    #validates :body, presence: true

    def to_s
        body
    end

    def attach_media(file:)
        media = Media.create(message_id: id,conversation_id: conversation.id)
        media.file.attach(file) 
        media.save
        return media
    end
   
end