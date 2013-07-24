class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.string :state
      t.string :number
      t.string :phone

      t.timestamps
    end
  end
end
