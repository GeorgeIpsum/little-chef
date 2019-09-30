class Recipe < ApplicationRecord
  has_many :instructions, dependent: :destroy

  validates_presence_of :title, :created_by
end
