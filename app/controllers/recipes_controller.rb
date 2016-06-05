class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def show
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def edit
  end

  def destroy
    if @recipe.destroy
      redirect_to root_path
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description)
  end

end
