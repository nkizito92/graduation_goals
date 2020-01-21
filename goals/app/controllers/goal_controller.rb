class GoalController < ApplicationController

    get "/goals" do 
        @goals = Goal.all
        erb :"/goals/jobs"
    end 

    get "/goals/new" do 

    end 
 
end 