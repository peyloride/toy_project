class Toy < ApplicationRecord
  has_many :lends
  has_many :comments
  belongs_to :user

  has_attached_file :image, styles: { large: "700x700", medium: "x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  acts_as_votable

  enum toy_type: [:akülü_araç, :okul_öncesi, :bebek, :figür, :lego, :kostüm, :dış_mekan]
end
