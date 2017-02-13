class User < ActiveRecord::Base
	has_many :books
	#mount_uploader :user_image, File3Uploader

	#has_one :book
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  
end
