require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_create_invalid
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    comment = Comment.first
    delete :destroy, :id => comment
    assert_redirected_to root_url
    assert !Comment.exists?(comment.id)
  end
end
