class Goal < ActiveRecord::Base 
    belongs_to :user
    validates :job, :description, presence: true 

end 