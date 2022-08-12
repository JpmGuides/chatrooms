class Message < ApplicationRecord

    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    belongs_to :conversation
    has_one :media

    validates :body, presence: true

    def to_s
        body
    end
end