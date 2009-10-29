class User < ActiveRecord::Base
  acts_as_authentic
  
  attr_protected :admin
  attr_accessor :password, :password_confirmation
  
  has_many :recipes, :dependent => :destroy
  
  def admin?
    self.admin
  end
  
  def own?(object)
    object.respond_to?(:user_id) && (object.user_id == self.id)
  end
end
