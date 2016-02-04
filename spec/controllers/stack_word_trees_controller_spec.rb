require 'rails_helper'

describe StackWordTreesController, type: :controller do

  describe "GET #index" do
    it "assigns all stack_word_trees as @stack_word_trees" do
      stack_word_tree = StackWordTree.create! valid_attributes
      get :index, {}

      expect(assigns(:stack_word_trees)).to eq([stack_word_tree])
    end
  end

  describe "GET #new" do
    it "assigns a new stack_word_tree as @stack_word_tree" do
      get :new, {}

      expect(assigns(:stack_word_tree)).to be_a_new(StackWordTree)
    end
  end

  describe "GET #edit" do
    it "assigns the requested stack_word_tree as @stack_word_tree" do
      stack_word_tree = StackWordTree.create! valid_attributes
      get :edit, { id: stack_word_tree.to_param }

      expect(assigns(:stack_word_tree)).to eq(stack_word_tree)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new StackWordTree" do
        expect {
          post :create, { stack_word_tree: valid_attributes }
        }.to change(StackWordTree, :count).by(1)
      end

      it "assigns a newly created stack_word_tree as @stack_word_tree" do
        post :create, { stack_word_tree: valid_attributes }

        expect(assigns(:stack_word_tree)).to be_a(StackWordTree)
        expect(assigns(:stack_word_tree)).to be_persisted
      end

      it "redirects to the edit page of created stack_word_tree" do
        post :create, { stack_word_tree: valid_attributes }

        expect(response).to redirect_to(edit_stack_word_tree_path(StackWordTree.last))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved stack_word_tree as @stack_word_tree" do
        post :create, { stack_word_tree: invalid_attributes }

        expect(assigns(:stack_word_tree)).to be_a_new(StackWordTree)
      end

      it "re-renders the 'new' template" do
        post :create, { stack_word_tree: invalid_attributes }

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested stack_word_tree" do
        stack_word_tree = StackWordTree.create! valid_attributes
        put :update, { id: stack_word_tree.to_param, stack_word_tree: new_attributes }
        stack_word_tree.reload

        expect(stack_word_tree.name).to eq("NewName")
        expect(stack_word_tree.result).to eq(["foo", "bar", "baz"])
      end

      it "assigns the requested stack_word_tree as @stack_word_tree" do
        stack_word_tree = StackWordTree.create! valid_attributes
        put :update, { id: stack_word_tree.to_param, stack_word_tree: valid_attributes }

        expect(assigns(:stack_word_tree)).to eq(stack_word_tree)
      end

      it "redirects to the updated stack_word_tree" do
        stack_word_tree = StackWordTree.create! valid_attributes
        put :update, { id: stack_word_tree.to_param, stack_word_tree: valid_attributes }

        expect(response).to redirect_to(edit_stack_word_tree_path(stack_word_tree))
      end
    end

    context "with invalid params" do
      it "assigns the stack_word_tree as @stack_word_tree" do
        stack_word_tree = StackWordTree.create! valid_attributes
        put :update, { id: stack_word_tree.to_param, stack_word_tree: invalid_attributes }

        expect(assigns(:stack_word_tree)).to eq(stack_word_tree)
      end

      it "re-renders the 'edit' template" do
        stack_word_tree = StackWordTree.create! valid_attributes
        put :update, { id: stack_word_tree.to_param, stack_word_tree: invalid_attributes }

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested stack_word_tree" do
      stack_word_tree = StackWordTree.create! valid_attributes

      expect {
        delete :destroy, { id: stack_word_tree.to_param }
      }.to change(StackWordTree, :count).by(-1)
    end

    it "redirects to the stack_word_trees list" do
      stack_word_tree = StackWordTree.create! valid_attributes
      delete :destroy, { id: stack_word_tree.to_param }

      expect(response).to redirect_to(stack_word_trees_url)
    end
  end

  def new_attributes
    valid_attributes.merge(name: "NewName", data_file: data_file)
  end

  def valid_attributes
    {
        result: ["foo", "bar", "baz"]
    }
  end

  def invalid_attributes
    {
        data_file: image_file
    }
  end

  def image_file
    @image_file ||= Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'rails.png'))
  end

  def data_file
    @data_file ||= Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'no_tree_file.dat'))
  end
end
