class Category < ApplicationRecord
    has_many :menu_items
    has_many :menus, through :menu_items
end