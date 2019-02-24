class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :link
      t.string :icon
      t.integer :rank
      t.integer :user_id
    end
  end
end
