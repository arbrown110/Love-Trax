class Trax < ActiveRecord::Base
    belongs_to :user
    validates :name, :date, :score, :location, :number, :interest, presence: true
    
end    