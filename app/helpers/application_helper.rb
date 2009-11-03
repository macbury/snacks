# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title
    title = "Przekaska"
    title += " - #{@title}" unless @title.nil?
    
    return title
  end
  
  def rss_link(title, path)
    tag :link, :type => 'application/rss+xml', :title => title, :href => path
  end

  def sort_tab(name, tab)
    options = { :page => params[:page] || 1 , :sort => tab.to_s, :ingredients => params[:ingredients] }
    if tab.to_s == @sort_type
      content_tag(:span, name)
    else
      link_to name, options
    end
  end
  
  def avatar_for(user, size=120)
    image_tag user.gravatar_url(:size => size)
  end
  
  def development?
    (RAILS_ENV=="development")
  end
  
end
