class Comment < ActiveRecord::Base
  validates_presence_of :body
  validates_length_of :body, :minimum => 3

  xss_terminate
  belongs_to :user
  belongs_to :recipe
end
