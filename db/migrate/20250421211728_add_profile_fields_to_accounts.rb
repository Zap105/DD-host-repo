class AddProfileFieldsToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :phone, :string
  end
end
