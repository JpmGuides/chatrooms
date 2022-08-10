class Participant < ApplicationRecord

    has_many :user
    has_many :messages

    validates :user, presence: true

    def to_s
        user.name
    end
end