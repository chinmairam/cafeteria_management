class Menu < ActiveRecord::Base
    has_many :menu_items, dependent: :destroy
    validates :name, presence: true, uniqueness: true
end
