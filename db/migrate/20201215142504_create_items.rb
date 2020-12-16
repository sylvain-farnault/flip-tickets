class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.references :topic, null: false, foreign_key: true
      t.integer :success, default: 0
      t.integer :errors, default: 0
      t.boolean :hide, default: false

      t.timestamps
    end
  end
end
