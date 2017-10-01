class AddIsAcceptedToLends < ActiveRecord::Migration[5.1]
  def change
    add_column :lends, :is_accepted, :boolean
  end
end
