class SessionsController < ApplicationController

	def create
		user = find_by_binary_search(params[:user_name])
		if user && passwords_match(params[:user_name], params[:password])
			session[:user_id] = params[:user_name]
			redirect_to root_url, notice: 'Logged in'
		else
			flash[:error] = 'Invalid credentials'
			render 'new'
		end
	end

	def new
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url
	end

	private 

		def passwords_match(name, pwd)
			file = File.read('db.json')
			db_obj = JSON.parse(file)
			pwds_obj = db_obj['passwords']
			if pwds_obj[name]['pwd'] == pwd
				return true
			else
				return false
			end
		end

end
