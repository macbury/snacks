class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe, :counter_cache => true
end
