class Lend < ApplicationRecord
  belongs_to :user, class_name: 'User',foreign_key: :owner_id
  belongs_to :toy
end
