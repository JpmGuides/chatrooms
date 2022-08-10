class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :index
      t.string :body
      t.references :author,index: true, foreign_key: { to_table: :participants }, null: false
      t.references :conversation,index: true, foreign_key: true, null: false
      t.timestamps
    end
  end
end
