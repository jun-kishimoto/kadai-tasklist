class Task < ApplicationRecord
    validates :content, presence: true, length: { maximum: 30 }
    validates :status, presence: true, length: { maximum: 30 }
    validates :deadline, presence: true, length: { maximum: 30 }
end
