# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title
    title = "Przekaska"
    title += " - #{@title}" unless @title.nil?
    
    return title
  end
  
end
