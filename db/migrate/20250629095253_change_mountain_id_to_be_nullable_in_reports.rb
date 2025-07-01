class ChangeMountainIdToBeNullableInReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :mountain_id, true
  end
end
