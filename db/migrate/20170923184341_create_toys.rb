class CreateToys < ActiveRecord::Migration[5.1]
  def change
    create_table :toys do |t|
      t.string :name
      t.integer :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
