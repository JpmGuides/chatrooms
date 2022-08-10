class Media < ApplicationRecord

    has_one :message, dependent: :destroy
    has_one :conversation, dependent: :destroy

    validates :message, presence: true
    validates :name , presence: true
    validates :conversation, presence: true

    def to_s
        name
    end
end