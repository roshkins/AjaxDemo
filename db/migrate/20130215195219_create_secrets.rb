class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :text
      t.timestamps
    end
  end
end
