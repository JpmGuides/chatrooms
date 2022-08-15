class Media < ApplicationRecord
    self.table_name = 'medium'

    has_one_attached :file
    
    belongs_to :message, dependent: :destroy
    belongs_to :conversation, dependent: :destroy

    validates :message, presence: true
    validates :conversation, presence: true
end