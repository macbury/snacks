xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Ostatnio dodane przepisy'
    xml.link recipes_url(:sort => 'date', :page => 1)
    
    for recipe in @recipes
      xml.item do
        xml.title recipe.title
        xml.description recipe.tags.map(&:name).join(', ')
        xml.pubDate recipe.created_at.to_s(:rfc822)
        xml.link recipe_url(recipe)
        xml.guid recipe_url(recipe)
      end
      
    end
    
  end
end