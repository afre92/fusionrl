class DashboardController < ApplicationController
  def index
  	file = File.read('db.json')
		db_obj = JSON.parse(file)
		@users = db_obj['user_names'].sort!
  end
end
