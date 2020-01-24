class GoalController < ApplicationController

    get "/goals" do 
        @goals = Goal.all
        if logged_in?
         erb :"/goals/jobs"
        else 
            redirect '/login'
        end 
    end 

#create 
    get "/goals/new" do 
        if logged_in?
            erb :"/goals/new"
        else
            redirect '/login'
        end 
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
        if logged_in?
            @goal =  Goal.find_by_id(params[:id])
            erb :"/goals/show"
        else 
            redirect "/"
        end 
    end 

#update 
    get '/goals/:id/edit' do 
        @goal = Goal.find_by_id(params[:id])
        if logged_in?
            if current_user.id == @goal.user_id
                erb :"/goals/edit"
            else 
                redirect "/goals/#{@goal.id}"
            end
        else  
            redirect "/"
        end
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
            redirect "/goals"
        end
    end 

 
end 