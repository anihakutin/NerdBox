class CreateHardwareSetups < ActiveRecord::Migration
  def change
    create_table :hardware_setups do |t|

      t.timestamps null: false
    end
  end
end
