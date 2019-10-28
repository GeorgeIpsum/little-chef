# frozen_string_literal: true

module V1
  class RecipesController < ApplicationController
    before_action :set_recipe, only: %i[show update destroy]

    def index
      @recipes = current_user.recipes.paginate(page: params[:page], per_page: 20)
      json_response(@recipes)
    end

    def show
      json_response(@recipe)
    end

    def create
      @recipe = current_user.recipes.create!(recipe_params)
      json_response(@recipe, :created)
    end

    def update
      @recipe.update(recipe_params)
      head :no_content
    end

    def destroy
      @recipe.destroy
      head :no_content
    end

    private

    def recipe_params
      params.permit(:title)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end
  end
end
