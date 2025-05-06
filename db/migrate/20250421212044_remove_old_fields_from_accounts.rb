# frozen_string_literal: true

class RemoveOldFieldsFromAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_index :payment_sources, :account_id
    add_index :payment_sources, :account_id # re-add without unique constraint
  end
end
