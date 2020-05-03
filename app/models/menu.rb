class Menu < ApplicationRecord
    has_many :menu_items, dependent: :destroy
    validates :name, presence: true, uniqueness: true
end
