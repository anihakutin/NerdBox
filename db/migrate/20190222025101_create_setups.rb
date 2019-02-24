class CreateSetups < ActiveRecord::Migration
  def change
    create_table :setups do |t|
      t.string :name
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :specs
      t.string :rank
      t.integer :user_id
    end
  end
end
