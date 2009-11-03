class IngredientsController < ApplicationController
  title "chmura składników"
  
  def index
    @ingredients = Tag.all( :select => 'tags.*, count(taggings.taggable_id) AS tag_count',
                            :conditions => { :kind => 'ingredient' }, 
                            :joins => [ :taggings ], 
                            :group => 'tags.id', 
                            :order => 'tags.name' )
  end
  
  def auto_complete
    @ingredients = Tag.all :conditions => { :name.like => "%#{params[:q]}%" }, :limit => 10
    
    render :text => @ingredients.map { |i| i.name }.join("\n")
  end
end
