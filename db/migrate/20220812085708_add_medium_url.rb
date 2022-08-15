class AddMediaUrl < ActiveRecord::Migration[6.1]
  def change
    rename_column :medium, :name, :file
  end
end
