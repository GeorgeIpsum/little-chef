class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_by, :created_at, :updated_at

  has_many :instructions
end
