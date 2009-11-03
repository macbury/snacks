require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Favorite.new.valid?
  end
end
