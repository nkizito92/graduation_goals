class UserController < ApplicationController
    

    get "/" do
        redirect_if_login
        erb :index
    end
    
    get '/login' do 
        redirect_if_login 
        erb :"/users/login"
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
        redirect_if_login
        erb :"/users/signup"
    end

    post "/signup" do 
        @new_user = User.new(params)
        @old_user = User.all.find_by(username: params[:username])
        if @new_user.valid? && !@old_user
            @new_user.username = params[:username].downcase
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