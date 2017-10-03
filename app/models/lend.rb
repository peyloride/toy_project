class Lend < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :lender, class_name: 'User', foreign_key: :borrower_id
  belongs_to :toy
end
