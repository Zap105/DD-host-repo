class AddAccountToPaymentSources < ActiveRecord::Migration[7.1]
  def change
    add_reference :payment_sources, :account, null: false, foreign_key: true, index: {unique:true}
  end
end
