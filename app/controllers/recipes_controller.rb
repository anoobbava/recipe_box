class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :destroy, :update]
  before_action :authenticate_user!, except: [:index, :show ]

  def index
    @recipes = Recipe.all.order('created_at DESC')
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe, notice: 'successfully added'
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
    if @recipe.user == current_user
      @recipe.destroy
      redirect_to root_path
    else
      render @recipe, notice: 'you cant delete others recipe'
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name,
                                    :_destroy], directions_attributes: [:id, :step, :_destroy])
  end

end
