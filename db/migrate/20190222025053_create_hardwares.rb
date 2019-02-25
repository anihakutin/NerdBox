class CreateHardwares < ActiveRecord::Migration
  def change
    create_table :hardwares do |t|
      t.string :name
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :link
      t.string :rank
      t.integer :hardwareable_id
      t.string  :hardwareable_type
      t.timestamps null: false
    end
  end
end
