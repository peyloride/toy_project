class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :toy

  acts_as_votable
end
