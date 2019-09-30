class Instruction < ApplicationRecord
  belongs_to :recipe

  validates_presence_of :text
end
