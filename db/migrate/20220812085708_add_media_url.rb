class AddMediaUrl < ActiveRecord::Migration[6.1]
  def change
    rename_column :media, :name, :file
  end
end
