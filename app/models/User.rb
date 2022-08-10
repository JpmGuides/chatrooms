class User < ApplicationRecord

    has_many :participants
    has_many :messages, through: :participants
    has_many :conversations, through: :participants

    validates :name, presence: true, length: { minimum: 3 }

    def to_s
        name
    end
end