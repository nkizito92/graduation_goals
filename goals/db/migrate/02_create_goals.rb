class CreateGoals < ActiveRecord::Migration
    def change 
        create_table :goals do |t|
            t.string :job
            t.string :description
            t.string :user_id
        end
    end
end