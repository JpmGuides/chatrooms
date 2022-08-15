class Conversation < ApplicationRecord

    has_many :participants
    has_many :messages

    validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }

    def to_s
        name
    end
end