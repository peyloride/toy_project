class AddAttachmentImageToToys < ActiveRecord::Migration[5.1]
  def self.up
    change_table :toys do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :toys, :image
  end
end
