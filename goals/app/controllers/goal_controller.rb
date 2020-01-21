Rack::MethodOverride
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
        @goal = Goal.new(job: params[:job], description: params[:description])
        if @goal.job.empty?
            redirect "/goals/new"
        else 
            @goal.user_id = current_user.id
            @goal.save
            redirect "/goals/#{@goal.id}"
        end 
    end 
#read
# find the users id
    get "/goals/:id" do 
        @goal =  Goal.find_by_id(params[:id])
        erb :"/goals/show"
    end 

#update 
    get '/goals/:id/edit' do 
        @goal = Goal.find_by_id(params[:id])
        if current_user.id == @goal.user_id
            erb :"/goals/edit"
        else 
            redirect "/goals/#{@goal.id}"
        end
    end

    patch '/goals' do 
       goal = Goal.find_by(user_id: current_user.id)
        goal.update(job: params[:job], description: params[:description])
        redirect "/goals/#{goal.id}"
    end 

#delete 
    delete '/goals' do 
        goal = Goal.find_by(user_id: current_user.id)
        goal.delete_all
        redirect "/goals"
    end 

 
end 