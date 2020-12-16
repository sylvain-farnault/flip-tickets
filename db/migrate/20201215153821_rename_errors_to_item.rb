class RenameErrorsToItem < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :errors, :mistakes
  end
end
