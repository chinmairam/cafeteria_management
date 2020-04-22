class Menu < ActiveRecord::Base
    has_many :items
    has_many :categories, through :menu_items
end
