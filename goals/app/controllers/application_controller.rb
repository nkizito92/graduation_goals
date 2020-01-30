require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :views, 'app/views'

  end

  helpers do 
    def logged_in?
      !!session[:user_id]
    end 

    def current_user 
      User.find(session[:user_id])
    end

    def check_login_redirect
      if !logged_in?
        redirect "/login"
      end
    end 

    def redirect_if_login
      if logged_in?
        redirect '/goals'
      end
    end

    def matching_ids
      current_user.id == @goal.user_id
    end 
    
  end

end
