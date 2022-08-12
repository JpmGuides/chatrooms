class CreateMedia < ActiveRecord::Migration[6.1]
  def change
    create_table :media do |t|
      t.string :name
      t.references :message, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
