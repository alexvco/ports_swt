class StackWordTreesController < ApplicationController
  before_action :set_stack_word_tree, only: [:show, :edit, :update, :destroy]

  def index
    @stack_word_trees = StackWordTree.all
  end

  def show
  end

  def new
    @stack_word_tree = StackWordTree.new
  end

  def edit
  end

  def create
    @stack_word_tree = StackWordTree.new(stack_word_tree_params)

    respond_to do |format|
      if @stack_word_tree.save
        @stack_word_tree.find_longest_stack_tree
        format.html { redirect_to edit_stack_word_tree_path(@stack_word_tree), notice: "Stack word tree was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @stack_word_tree.update(stack_word_tree_params)
        @stack_word_tree.find_longest_stack_tree
        format.html { redirect_to edit_stack_word_tree_path(@stack_word_tree), notice: "Stack word tree was successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @stack_word_tree.destroy
    respond_to do |format|
      format.html { redirect_to stack_word_trees_url, notice: "Stack word tree was successfully removed." }
    end
  end

  private

  def set_stack_word_tree
    @stack_word_tree = StackWordTree.find(params[:id])
  end

  def stack_word_tree_params
    params.require(:stack_word_tree).permit(:name, :result, :data_file)
  end
end
