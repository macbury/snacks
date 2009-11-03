class User < ActiveRecord::Base
  acts_as_authentic
  is_gravtastic!
  
  attr_protected :admin
  
  has_many :recipes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  def admin?
    self.admin
  end
  
  def own?(object)
    object.respond_to?(:user_id) && (object.user_id == self.id) || admin?
  end
end
