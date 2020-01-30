class GoalController < ApplicationController

    get "/goals" do 
        @goals = Goal.all
        check_login_redirect
        erb :"/goals/jobs"
    end 

#create 
    get "/goals/new" do 
        check_login_redirect
        erb :"/goals/new"
    end 

    post "/goals" do 
        @goal = Goal.new(params)
        if @goal.job.empty?
            redirect "/goals/new"
        else 
            matching_ids
            @goal.save
            redirect "/goals/#{@goal.id}"
        end 
    end 
#read
# find the users id
    get "/goals/:id" do 
        set_goal
        check_login_redirect
        !params[:id] ? (redirect '/login') : (redirect '/goals')
        erb :"/goals/show"
    end 

#update 
    get '/goals/:id/edit' do 
        set_goal
        if logged_in?
                if matching_ids
                    erb :"/goals/edit"
                else 
                    redirect "/goals/#{@goal.id}"
                end
        else  
            redirect "/login"
        end
    end

    patch '/goals/:id' do 
       set_goal
       if @goal.valid? && matching_ids
            @goal.update(job: params[:job], description: params[:description])
            redirect "/goals/#{@goal.id}"
       else  
            redirect "/goals/#{@goal.id}/edit"
       end 

    end 

#delete 
    delete '/goals/:id' do 
        set_goal
        if logged_in? && matching_ids
            @goal.delete
        end
        redirect "/goals"
    end 
    private 
        def set_goal
           @goal = Goal.find_by_id(params[:id])
        end 
end 