class AddDescriptionToToy < ActiveRecord::Migration[5.1]
  def change
    add_column :toys, :description, :text
  end
end
