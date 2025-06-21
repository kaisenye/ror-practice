class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.string :category
      t.references :category_ref, null: true, foreign_key: { to_table: :categories }
      t.date :date
      t.string :user_name

      t.timestamps
    end

    add_index :expenses, :date
    add_index :expenses, :category
  end
end
