class UsersController < ApplicationController

  def new
  end

  def create
		file = File.read('db.json')
		db_obj = JSON.parse(file)	
		name_taken = name_availability(params['user_name'])
		params['user_name'] = assign_new_name(params['user_name']) if name_taken
  	db = File.new('db.json', 'w+')
 		db_obj['user_names'].push(params['user_name'])
 		db_obj['passwords'][params['user_name'].to_sym] = {'pwd': params['password']}
 		db.puts(db_obj.to_json)
  	db.close
  	session[:user_id] = params['user_name']
  	if name_taken
  		flash[:error] = "Your user name was changed to #{params['user_name']}" 
  	else
  		flash[:success] = "User #{params['user_name'].capitalize} created" 
  	end
  	redirect_to root_path
  end

  def name_availability(name)
  	if find_by_binary_search(name)
  		return true
  	else
  		return false
  	end
  end

  def assign_new_name(name)
  	file = File.read('db.json')
		db_obj = JSON.parse(file)	
		new_name = name
  	while db_obj['user_names'].include?(new_name)
	  	arr_name = new_name.split('_')
			if arr_name.length > 1
	  		name_index = arr_name.last
	  		arr_name[-1] = (arr_name[-1].to_i + 1).to_s
	  		new_name = arr_name.join('_')
			else
	  		new_name = new_name+'_1'
			end
  	end
  	return new_name
  end

end
