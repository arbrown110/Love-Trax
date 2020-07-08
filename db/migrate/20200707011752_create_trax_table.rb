class CreateTraxTable < ActiveRecord::Migration[5.2]
  def change
    create_table :trax do |t|
      t.string :name
      t.datetime :date
      t.integer :score
      t.text :location
      t.integer :number
      t.text :interest
      
    end  
  end
end
