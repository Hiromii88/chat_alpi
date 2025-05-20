class CreateMountains < ActiveRecord::Migration[7.2]
  def change
    create_table :mountains do |t|
      t.string :name
      t.integer :height
      t.string :level
      t.text :feature
      t.boolean :mountain_hut
      t.integer :route_distance

      t.timestamps
    end
  end
end
