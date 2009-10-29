module RecipesHelper
  
  def render_ingredients_for_recipe(recipe)
    return recipe.tags.map do |tag|
      if @tags && @tags.include?(tag.name)
        content_tag(:i, tag.name)
      else
        tag.name
      end
    end.join(', ')
  end
  
end
