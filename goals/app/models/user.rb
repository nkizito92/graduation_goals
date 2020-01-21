class User < ActiveRecord::Base
    has_many :goals
    has_secure_password
end 