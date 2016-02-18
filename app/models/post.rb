class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy 
  validates :post_text, presence: true

  def self.show_user_post
  	@user_post = Post.all
  end
end