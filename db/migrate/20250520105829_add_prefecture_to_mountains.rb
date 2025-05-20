class AddPrefectureToMountains < ActiveRecord::Migration[7.2]
  def change
    add_column :mountains, :prefecture, :string
  end
end
