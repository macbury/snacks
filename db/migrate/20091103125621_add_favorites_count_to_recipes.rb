class AddFavoritesCountToRecipes < ActiveRecord::Migration
  def self.up
    add_column :recipes, :favorites_count, :integer, :default => 0
  end

  def self.down
    remove_column :recipes, :favorites_count
  end
end
