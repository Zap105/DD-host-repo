class AddDetailsToPaymentSources < ActiveRecord::Migration[7.1]
  def change
    add_column :payment_sources, :card_number, :string
    add_column :payment_sources, :cardholder_name, :string
    add_column :payment_sources, :expiration_month, :integer
    add_column :payment_sources, :expiration_year, :integer
    add_column :payment_sources, :cvv, :string
  end
end
