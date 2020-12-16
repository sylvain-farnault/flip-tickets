class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.string :key_term, default: "number"
      t.string :value_term, default: "mental image"

      t.timestamps
    end
  end
end
