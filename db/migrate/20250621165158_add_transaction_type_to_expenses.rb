class AddTransactionTypeToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :transaction_type, :string, default: 'expense', null: false
    add_index :expenses, :transaction_type

    # Update existing records to be expenses
    reversible do |dir|
      dir.up do
        execute "UPDATE expenses SET transaction_type = 'expense' WHERE transaction_type IS NULL"
      end
    end
  end
end
