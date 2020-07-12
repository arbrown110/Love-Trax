class User < ActiveRecord::Base
    has_secure_password
    has_many :trax
    validates :username, uniqueness: true, presence: true, length: { in: 3..10 }
    validates :email, uniqueness: true, presence: true

end    