# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Expense.destroy_all
Category.destroy_all

# Create categories for expenses
expense_categories_data = [
  { name: "Food", color: "bg-blue-500", icon: "🍽️" },
  { name: "Transportation", color: "bg-green-500", icon: "🚗" },
  { name: "Household", color: "bg-purple-500", icon: "🏠" },
  { name: "Rent", color: "bg-red-500", icon: "🏢" },
  { name: "Shopping", color: "bg-yellow-500", icon: "🛒" },
  { name: "Materials", color: "bg-indigo-500", icon: "📦" },
  { name: "Train", color: "bg-pink-500", icon: "🚆" }
]

# Create categories for income
income_categories_data = [
  { name: "Salary", color: "bg-emerald-500", icon: "💰" },
  { name: "Freelance", color: "bg-cyan-500", icon: "💻" },
  { name: "Investment", color: "bg-violet-500", icon: "📈" },
  { name: "Business", color: "bg-orange-500", icon: "🏪" },
  { name: "Gift", color: "bg-rose-500", icon: "🎁" },
  { name: "Other", color: "bg-gray-500", icon: "💸" }
]

# Create all categories
(expense_categories_data + income_categories_data).each do |cat|
  Category.create!(cat)
end

# Create sample expenses
expenses_data = [
  # Today's expenses
  { description: "Food order", amount: 459, category: "Food", date: Date.current, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Cab", amount: 243, category: "Transportation", date: Date.current, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Current bill", amount: 790, category: "Household", date: Date.current, user_name: "Jenny Yu", transaction_type: "expense" },

  # This month's expenses
  { description: "Monthly rent payment", amount: 25492, category: "Rent", date: Date.current.beginning_of_month, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Grocery shopping", amount: 3200, category: "Food", date: 2.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Office supplies", amount: 4259, category: "Materials", date: 3.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Train commute", amount: 1904, category: "Train", date: 1.week.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Weekly groceries", amount: 2850, category: "Food", date: 1.week.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Household items", amount: 6750, category: "Household", date: 10.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Taxi to airport", amount: 672, category: "Transportation", date: 5.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Online shopping", amount: 4910, category: "Shopping", date: 4.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Restaurant dinner", amount: 1250, category: "Food", date: 6.days.ago, user_name: "Jenny Yu", transaction_type: "expense" },

  # Previous months for trend data
  { description: "Previous month rent", amount: 25492, category: "Rent", date: 1.month.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Previous month food", amount: 8500, category: "Food", date: 1.month.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Previous transport", amount: 2200, category: "Transportation", date: 1.month.ago, user_name: "Jenny Yu", transaction_type: "expense" },

  { description: "Two months ago rent", amount: 25492, category: "Rent", date: 2.months.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Two months ago food", amount: 9200, category: "Food", date: 2.months.ago, user_name: "Jenny Yu", transaction_type: "expense" },
  { description: "Two months transport", amount: 1800, category: "Transportation", date: 2.months.ago, user_name: "Jenny Yu", transaction_type: "expense" }
]

# Create sample income
income_data = [
  # This month's income
  { description: "Monthly salary", amount: 75000, category: "Salary", date: Date.current.beginning_of_month, user_name: "Jenny Yu", transaction_type: "income" },
  { description: "Freelance project", amount: 12500, category: "Freelance", date: 3.days.ago, user_name: "Jenny Yu", transaction_type: "income" },
  { description: "Stock dividends", amount: 850, category: "Investment", date: 1.week.ago, user_name: "Jenny Yu", transaction_type: "income" },
  { description: "Birthday gift", amount: 500, category: "Gift", date: 5.days.ago, user_name: "Jenny Yu", transaction_type: "income" },

  # Previous months
  { description: "Previous month salary", amount: 75000, category: "Salary", date: 1.month.ago, user_name: "Jenny Yu", transaction_type: "income" },
  { description: "Previous freelance", amount: 8000, category: "Freelance", date: 1.month.ago, user_name: "Jenny Yu", transaction_type: "income" },

  { description: "Two months ago salary", amount: 75000, category: "Salary", date: 2.months.ago, user_name: "Jenny Yu", transaction_type: "income" },
  { description: "Investment return", amount: 3200, category: "Investment", date: 2.months.ago, user_name: "Jenny Yu", transaction_type: "income" }
]

# Create all transactions
(expenses_data + income_data).each do |transaction_data|
  # Remove category name from transaction_data and use it separately for string-based category lookup
  category_name = transaction_data.delete(:category)
  Expense.create!(transaction_data.merge(category: category_name))
end

puts "Created #{Category.count} categories and #{Expense.count} transactions (#{Expense.expenses.count} expenses, #{Expense.income.count} income)"
