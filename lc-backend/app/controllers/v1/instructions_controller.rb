# frozen_string_literal: true

module V1
  class InstructionsController < ApplicationController
    before_action :set_recipe
    before_action :set_recipe_instruction, only: %i[show update destroy]

    def index
      json_response(@recipe.instructions)
    end

    def show
      json_response(@instruction)
    end

    def create
      @recipe.instructions.create!(instruction_params)
      json_response(@recipe, :created)
    end

    def update
      @instruction.update(instruction_params)
      head :no_content
    end

    def destroy
      @instruction.destroy
      head :no_content
    end

    private

    def instruction_params
      params.permit(:text, :done)
    end

    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end

    def set_recipe_instruction
      @instruction = @recipe.instructions.find_by!(id: params[:id]) if @recipe
    end
  end
end
