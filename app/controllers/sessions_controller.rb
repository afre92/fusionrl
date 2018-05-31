class SessionsController < ApplicationController

  def create

  	user = find_by_binary_search(params[:user_name])
  	if user && passwords_match(params[:user_name], params[:password])
  		session[:user_id] = params[:user_name]
  		redirect_to root_url, notice: 'Logged in'
  		# login user
  	else
  		render 'new'
  		# show error
  	end
  	# get db if has been created, create otherwise. 
  	# add user and to array and pass with corresponding is
  	# save file
  end

  def new

  	# get db if exist
  end

  def destroy
  end


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

def find_by_binary_search(key)
	file = File.read('db.json')
	db_obj = JSON.parse(file)
	users_names = db_obj['user_names'].sort!

	low = 0
	high = users_names.length - 1

	while (low <= high)
	    middle = low + (( high - low ) / 2 )
	    
	    if users_names[middle] == key

	        return true
	    elsif users_names[middle] < key
	        low = middle + 1
	    else
	        high = middle - 1
	    end
	    
	end

	return false
end


end
