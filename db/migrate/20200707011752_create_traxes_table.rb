class CreateTraxesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :traxes do |t|
      t.string :name
      t.datetime :date
      t.integer :score
      t.text :location
      t.integer :number
      t.text :interest
      
    end  
  end
end
