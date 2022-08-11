class Media < ApplicationRecord

    belongs_to :message, dependent: :destroy
    belongs_to :conversation, dependent: :destroy

    validates :message, presence: true
    validates :name , presence: true
    validates :conversation, presence: true

    def to_s
        name
    end
end