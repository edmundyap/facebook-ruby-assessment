class User < ActiveRecord::Base

  has_secure_password
  #bcrypt defines .authenticate method behind the scene

  has_many :posts
  has_many :comments

  validates :full_name, presence: true
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create

  def self.authenticate(email,password)
     @user =  User.find_by(email: email)
     if @user && @user.authenticate(password)
      return @user
    else
      return false
    end
  end

    def self.show_users
      @user = User.all
    end
end