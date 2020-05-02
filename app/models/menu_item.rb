class MenuItem < ApplicationRecord
  belongs_to :menu
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true

  def pleasant_string
    "#{name} #{description} #{menu.name} #{price}"
  end
end
