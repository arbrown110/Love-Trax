class Trax < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name, :date, :score, :location,
    :number, :interest
    
end    