class CreateTraxTable < ActiveRecord::Migration
  def change
    create_table :trax do |t|
      t.string :name
      t.integer :date
      t.integer :score
      t.text :location
      t.integer :number
      t.text :interest
      t.integer :user_id
    end  
  end
end
