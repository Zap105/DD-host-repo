class CreatePaymentSources < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_sources do |t|
      t.string :payment_type
      t.text :info

      t.timestamps
    end
  end
end
