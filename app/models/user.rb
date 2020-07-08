class User < ActiveRecord::Base
    has_many :traxs
    has_secure_password
end    