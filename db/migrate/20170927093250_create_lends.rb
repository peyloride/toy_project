class CreateLends < ActiveRecord::Migration[5.1]
  def change
    create_table :lends do |t|
      t.integer :owner_id
      t.integer :borrower_id
      t.integer :toy_id

      t.timestamps
    end
  end
end
