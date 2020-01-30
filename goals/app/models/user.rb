class User < ActiveRecord::Base
    has_many :goals
    validates :username, :password, presence: true 
    has_secure_password
end 