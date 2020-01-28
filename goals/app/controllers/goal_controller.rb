class GoalController < ApplicationController

    get "/goals" do 
        @goals = Goal.all
        check_login_redirect("/goals/jobs", "/login")
    end 

#create 
    get "/goals/new" do 
        check_login_redirect("/goals/new", "/login")
        # if logged_in?
        #     erb :"/goals/new"
        # else
        #     redirect '/login'
        # end 
    end 

    post "/goals" do 
        @goal = Goal.new(job: params[:job], description: params[:description], user_id: current_user.id)
        if @goal.job.empty?
            redirect "/goals/new"
        else 
            @goal.save
            redirect "/goals/#{@goal.id}"
        end 
    end 
#read
# find the users id
    get "/goals/:id" do 
        @goal =  Goal.find_by_id(params[:id])
        check_login_redirect("/goals/show", "/")
        # if logged_in?
        #     erb :"/goals/show"
        # else 
        #     redirect "/"
        # end 
    end 

#update 
    get '/goals/:id/edit' do 
        @goal = Goal.find_by_id(params[:id])
        check_login_redirect(
            ( if current_user.id == @goal.user_id
                    erb :"/goals/edit"
                else 
                    redirect "/goals/#{@goal.id}"
                end), 
            "/")

        # if logged_in?
        #     if current_user.id == @goal.user_id
        #         erb :"/goals/edit"
        #     else 
        #         redirect "/goals/#{@goal.id}"
        #     end
        # else  
        #     redirect "/"
        # end
    end

    patch '/goals/:id' do 
       goal = Goal.find_by(id: params[:id])
       if !params[:job].empty? && !params[:description].empty? && current_user.id == goal.user_id
            goal.update(job: params[:job], description: params[:description])
            redirect "/goals/#{goal.id}"
       else  
            redirect "/goals/#{goal.id}/edit"
       end 

    end 

#delete 
    delete '/goals/:id' do 
        goal = Goal.find_by(id: params[:id])
        if logged_in? && current_user.id == goal.user_id
            goal.delete
        end
        redirect "/goals"
    end 

 
end 