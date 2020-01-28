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

    def check_login_redirect(user, direction)
      if logged_in?
        erb :"#{user}"
      else 
        redirect "#{direction}"
      end
    end 
  end

end
