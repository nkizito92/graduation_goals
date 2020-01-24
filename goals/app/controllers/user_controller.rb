class UserController < ApplicationController
    

    get "/" do
        if logged_in? 
            redirect "/goals"
        else 
            erb :index
        end 
    end
    
    get '/login' do 
        if logged_in? 
            redirect "/goals"
        else 
            erb :"/users/login"
        end 
    end 

    post "/login" do 
        @user = User.find_by(username: params[:username].downcase)
        if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to "/goals"
        else
			redirect "/login"
		end
    end
    # create*** new account
    get "/signup" do 
        if logged_in? 
            redirect "/goals"
        else 
            erb :"/users/signup"
        end
    end

    post "/signup" do 
        @new_user = User.new(username: params[:username].downcase, password: params[:password])
        @old_user = User.all.find_by(username: params[:username])
        if !params[:username].empty? && !params[:password].empty? && !@old_user
            @new_user.save
            session[:user_id] = @new_user.id
            redirect "/goals"
        else 
            redirect "/signup"
        end
    end 

    get '/logout' do 
        session.clear
        redirect "/login"
    end

end 