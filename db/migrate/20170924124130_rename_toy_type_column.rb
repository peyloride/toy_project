class RenameToyTypeColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :toys, :type, :toy_type
  end
end
