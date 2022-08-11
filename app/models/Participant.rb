class Participant < ApplicationRecord

    belongs_to :user
    belongs_to :conversation
    has_many :messages

    validates :user, presence: true

    def to_s
        user.name
    end
end