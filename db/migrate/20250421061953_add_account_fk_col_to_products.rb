class AddAccountFkColToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :account, foreign_key: true 
  end
end
