class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.integer :number
      t.datetime :date
      t.string :code
      t.string :violation
      t.decimal :amount

      t.timestamps
    end
  end
end
