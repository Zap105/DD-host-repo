class AddUserRefToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_reference :accounts, :user, null: false, foreign_key: true, index: { unique: true }
  end
end
