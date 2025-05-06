# frozen_string_literal: true

# == Schema Information
#
# Table name: payment_sources
#
#  id               :bigint           not null, primary key
#  card_number      :string
#  cardholder_name  :string
#  cvv              :string
#  expiration_month :integer
#  expiration_year  :integer
#  payment_type     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  account_id       :bigint           not null
#
# Indexes
#
#  index_payment_sources_on_account_id  (account_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#
class PaymentSource < ApplicationRecord
  belongs_to :account

  METHODS = %w[Visa Mastercard PayPal DebitCard]

  validates :payment_type,
            presence:  true,
            inclusion: {
              in:      METHODS,
              message: '%<value>s is not a supported payment method'
            }

  validates :card_number, :cardholder_name, :expiration_month,
            :expiration_year, :cvv, presence: true
end
