class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :title, :null => false
      t.text :body, :null => false

      t.integer :author_id, :null => false
      t.integer :recipient_id, :null => false

      t.timestamps
    end
  end
end
