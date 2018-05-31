class DashboardController < ApplicationController
	before_action :authenticate

  def index
  	file = File.read('db.json')
		db_obj = JSON.parse(file)
		@users = db_obj['user_names'].sort!
  end

  private

  	def authenticate
	  	if session[:user_id]
	  		return if find_by_binary_search(session[:user_id])
	  	end
	  	return redirect_to login_path
	  end
end
