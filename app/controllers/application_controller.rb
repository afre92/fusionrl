class ApplicationController < ActionController::Base

	private

		def current_user
			exist ||= find_by_binary_search(session[:user_id]) if session[:user_id]
			@current_user = session[:user_id] if exist
		end
		helper_method :current_user

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
