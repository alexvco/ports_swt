require "rails_helper"

describe StackWordTreesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/stack_word_trees").to route_to("stack_word_trees#index")
    end

    it "routes to #new" do
      expect(get: "/stack_word_trees/new").to route_to("stack_word_trees#new")
    end

    it "routes to #edit" do
      expect(get: "/stack_word_trees/1/edit").to route_to("stack_word_trees#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/stack_word_trees").to route_to("stack_word_trees#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/stack_word_trees/1").to route_to("stack_word_trees#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/stack_word_trees/1").to route_to("stack_word_trees#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/stack_word_trees/1").to route_to("stack_word_trees#destroy", id: "1")
    end
  end
end
