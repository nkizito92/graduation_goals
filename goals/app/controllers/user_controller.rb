class UserController < ApplicationController

    get "/" do
        erb :index
    end
    
    get '/login' do 
        if logged_in? 
            redirect "/goals"
        else 
            erb :"/users/login"
        end 
    end 

    post "/login" do 
        @user = User.find_by(username: params[:username])
        if @user == @user.authenticate(params[:password])
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
        @new_user = User.create(username: params[:username], password: params[:password])
        if !params[:username].empty? && !params[:password].empty? 
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

    get '/users/:id' do 
        @user = User.find_by(params[:id])
        erb :"/users/show/#{@user.id}"
    end 

end 