class Recipe < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :instructions, :ingredient_list
  validates_length_of :title, :within => 3..255
  validates_uniqueness_of :title
  
  has_permalink :title, :update => true
  
  is_taggable :ingredients
  
  attr_accessible :title, :instructions, :ingredient_list
  
  def to_param
    permalink
  end
  
end
