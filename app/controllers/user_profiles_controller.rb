class UserProfilesController < ApplicationController

  def show
  	#dont need this line below becasue its now in the application controller :)
  	#@user = User.find(params[:id])
  	@user_orgs = @user.books
  end

  

end
