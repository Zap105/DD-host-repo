class RemoveInfoFromPaymentSources < ActiveRecord::Migration[7.1]
  def change
    remove_column :payment_sources, :info, :text
  end
end
