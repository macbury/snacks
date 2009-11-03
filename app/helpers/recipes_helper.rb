module RecipesHelper
  
  def render_ingredients_for_recipe(recipe)
    ingredients = recipe.tags.map(&:name)
    
    if @tags
      have = []
      need = []
      
      ingredients.each do |ingredient|
        if @tags.grep(/#{ingredient.gsub(' ','|')}/i).empty?
          need << h(ingredient)
        else
          have << h(ingredient)
        end
      end
      
      out = "<b>Masz:</b> "+ have.join(', ')
      out += " <b>Potrzebujesz:</b> " + need.join(', ') unless need.size == 0
      return out
    else
      return "<b>Składniki:</b> " + ingredients.join(', ')
    end

  end
  
end
