class AddPlateToCitation < ActiveRecord::Migration
  def change
    add_reference :citations, :plate, index: true
  end
end
