require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  def test_destroy
    favorite = Favorite.first
    delete :destroy, :id => favorite
    assert_redirected_to root_url
    assert !Favorite.exists?(favorite.id)
  end
  
  def test_create_invalid
    Favorite.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Favorite.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
end
