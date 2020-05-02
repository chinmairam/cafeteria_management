class Menu < ActiveRecord::Base
    has_many :menu_items, dependent: :
    validates :name, presence: true, uniqueness: true
end
