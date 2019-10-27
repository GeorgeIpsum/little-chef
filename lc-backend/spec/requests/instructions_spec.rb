require 'rails_helper'

RSpec.describe 'Instructions API:' do
  let!(:recipe) { create(:recipe) }
  let!(:instructions) { create_list(:instruction, 20, recipe_id: recipe.id) }
  let(:recipe_id) { recipe.id }
  let(:id) { instructions.first.id }

  describe 'GET /recipes/:recipe_id/instructions' do
    before { get "/recipes/#{recipe_id}/instructions" }

    context 'when recipe exists' do
      it 'returns all recipe instructions' do
        expect(json.size).to eq(20)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when recipe does not exist' do
      let(:recipe_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Recipe/)
      end
    end
  end

  describe 'GET /recipes/:recipe_id/instructions/:id' do
    before { get "/recipes/#{recipe_id}/instructions/#{id}" }

    context 'when recipe instruction exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the instruction' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when recipe instruction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Instruction/)
      end
    end
  end

  describe 'POST /recipes/:recipe_id/instructions' do
    let(:valid_attributes) { { text: 'Sear the steak', done: false } }

    context 'when request attributes are valid' do
      before { post "/recipes/#{recipe_id}/instructions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/recipes/#{recipe_id}/instructions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Text can't be blank/)
      end
    end
  end

  describe 'PUT /recipes/:recipe_id/instructions/:id' do
    let(:valid_attributes) { { text: 'Pan fry the steak' } }

    before { put "/recipes/#{recipe_id}/instructions/#{id}", params: valid_attributes }

    context 'when instruction exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the instruction' do
        updated_instruction = Instruction.find(id)
        expect(updated_instruction.text).to match(/Pan fry the steak/)
      end
    end

    context 'when the instruction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Instruction/)
      end
    end
  end

  describe 'DELETE /recipes/:id' do
    before { delete "/recipes/#{recipe_id}/instructions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  
end
