class AddAreaToMountains < ActiveRecord::Migration[7.2]
  def change
    add_column :mountains, :area, :string
  end
end
