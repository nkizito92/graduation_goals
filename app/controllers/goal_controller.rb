class GoalController < ApplicationController

    get "/goals" do 
        check_login_redirect
        @goals = Goal.all
        erb :"/goals/jobs"
    end 

#create 
    get "/goals/new" do 
        check_login_redirect
        erb :"/goals/new"
    end 

    post "/goals" do 
        check_login_redirect
        @goal = Goal.new(params)
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
        check_login_redirect
        set_goal
        erb :"/goals/show"
    end 

#update 
    get '/goals/:id/edit' do 
        check_login_redirect
        set_goal
        if matching_ids?
            erb :"/goals/edit"
        else 
            redirect "/goals/#{@goal.id}"
        end
    end

    patch '/goals/:id' do 
        check_login_redirect
       set_goal
       if  matching_ids? && @goal.update(params[:goal])
            redirect "/goals/#{@goal.id}"
       else  
            redirect "/goals/#{@goal.id}/edit"
       end 

    end 

#delete 
    delete '/goals/:id' do 
        check_login_redirect
        set_goal
        if matching_ids?
            @goal.delete
        end
        redirect "/goals"
    end 
    private 
        def set_goal
           @goal = Goal.find_by_id(params[:id])
           if !@goal
            redirect '/goals'
           end 
        end 
end 