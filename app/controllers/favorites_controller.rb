class FavoritesController < ApplicationController
  before_filter :login_required, :find_recipe
  
  def create
    @favorite = self.current_user.favorites.create(:recipe_id => @recipe.id)
    
    flash[:notice] = "Przepis dodany do ulubionych"
    redirect_to @recipe
  end
  
  def destroy
    @favorite = self.current_user.favorites.find(params[:id])
    @favorite.destroy
    
    flash[:notice] = "Przepis usunięty z ulubionych"
    redirect_to @recipe
  end
  
  protected
    
    def find_recipe
      @recipe = Recipe.find_by_permalink(params[:recipe_id])
    end
end
