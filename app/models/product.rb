# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :bigint
#
# Indexes
#
#  index_products_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class Product < ApplicationRecord
  belongs_to :account
  has_many_attached :photos
  has_many_attached :templates
  

  validates :name,
    presence: true

  validates :price,
    presence: true,
    numericality: { greater_than_or_equal_to: 0 }

  validates :description,
    length: { maximum: 1_000 },
    allow_blank: false
end

