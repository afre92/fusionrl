class UsersController < ApplicationController

  def new
  	# @user = User.new
  end

  def create
  	# create new user
		file = File.read('db.json')
		db_obj = JSON.parse(file)	
		# look for duplicates using binary search
		name_taken = name_availability(params['user_name'])
		params['user_name'] = assign_new_name(params['user_name']) if name_taken
  	db = File.new('db.json', 'w+')
 		db_obj['user_names'].push(params['user_name'])
 		db_obj['passwords'][params['user_name'].to_sym] = {'pwd': params['password']}
 		db.puts(db_obj.to_json)
  	db.close
  end

  def name_availability(name)
  	if find_by_binary_search(name)
  		# assign_new_name(name)
  		return true
  	else
  		return false
  	end
  end

  def assign_new_name(name)
  	arr_name = name.split('_')
		if arr_name.length > 1
  		name_index = arr_name.last
  		arr_name[-1] = (arr_name[-1].to_i + 1).to_s
  		new_name = arr_name.join('_')
		else
  		new_name = name+'_1'
		end
		new_name
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
