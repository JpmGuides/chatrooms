class Message < ApplicationRecord

    has_one :author, class_name: 'User', foreign_key: 'author_id'
    has_one :conversation

    validates :body, presence: true

    def to_s
        body
    end
end