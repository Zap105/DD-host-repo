# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  password   :string
#  phone      :string
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Account < ApplicationRecord
  belongs_to :user, inverse_of: :account
  has_many :payment_sources, dependent: :destroy
  has_many :products, dependent: :destroy

  accepts_nested_attributes_for :user

  validates :user_id, uniqueness: true

  validates :user_name,
            uniqueness:  true,
            allow_blank: true

  validates :first_name,
            length:      { maximum: 50 },
            allow_blank: true

  validates :last_name,
            length:      { maximum: 50 },
            allow_blank: true

  VALID_PHONE_REGEX = /\A\+?[0-9]{7,15}\z/
  validates :phone,
            format:      { with:    VALID_PHONE_REGEX,
                           message: 'must be 7–15 digits, optional leading ‘+’' },
            allow_blank: true
end
