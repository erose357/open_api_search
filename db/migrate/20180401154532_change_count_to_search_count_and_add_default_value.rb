class ChangeCountToSearchCountAndAddDefaultValue < ActiveRecord::Migration
  def change
    rename_column :searches, :count, :search_count
    change_column_default :searches, :search_count, 1
  end
end
