require 'rails_helper'

RSpec.describe "StackWordTrees", type: :request do
  describe "GET /stack_word_trees" do
    it "works! (now write some real specs)" do
      get stack_word_trees_path
      expect(response).to have_http_status(200)
    end
  end
end
