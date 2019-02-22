class CreateHardwares < ActiveRecord::Migration
  def change
    create_table :hardwares do |t|

      t.timestamps null: false
    end
  end
end
