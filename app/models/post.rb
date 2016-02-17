class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  def self.show_user_post
  	@user_post = Post.all
  end
end