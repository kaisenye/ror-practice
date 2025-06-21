class Expense < ApplicationRecord
  belongs_to :category_ref, class_name: "Category", optional: true

  validates :description, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :user_name, presence: true
  validates :transaction_type, presence: true, inclusion: { in: %w[expense income] }

  scope :for_date, ->(date) { where(date: date) }
  scope :for_month, ->(month, year) { where(date: Date.new(year, month).beginning_of_month..Date.new(year, month).end_of_month) }
  scope :by_category, ->(category) { where(category: category) }
  scope :recent, -> { order(date: :desc, created_at: :desc) }
  scope :expenses, -> { where(transaction_type: "expense") }
  scope :income, -> { where(transaction_type: "income") }

  def self.daily_total(date = Date.current)
    for_date(date).sum(:amount)
  end

  def self.daily_expense_total(date = Date.current)
    expenses.for_date(date).sum(:amount)
  end

  def self.daily_income_total(date = Date.current)
    income.for_date(date).sum(:amount)
  end

  def self.monthly_total(month = Date.current.month, year = Date.current.year)
    for_month(month, year).sum(:amount)
  end

  def self.monthly_expense_total(month = Date.current.month, year = Date.current.year)
    expenses.for_month(month, year).sum(:amount)
  end

  def self.monthly_income_total(month = Date.current.month, year = Date.current.year)
    income.for_month(month, year).sum(:amount)
  end

  def self.category_totals
    group(:category).sum(:amount).sort_by { |_, amount| -amount }
  end

  def self.expense_category_totals
    expenses.group(:category).sum(:amount).sort_by { |_, amount| -amount }
  end

  def self.income_category_totals
    income.group(:category).sum(:amount).sort_by { |_, amount| -amount }
  end

  def self.monthly_trend(months = 6)
    months.times.map do |i|
      month_date = i.months.ago
      {
        month: month_date.strftime("%b"),
        amount: for_month(month_date.month, month_date.year).sum(:amount),
        expenses: expenses.for_month(month_date.month, month_date.year).sum(:amount),
        income: income.for_month(month_date.month, month_date.year).sum(:amount)
      }
    end.reverse
  end

  def self.net_worth
    income.sum(:amount) - expenses.sum(:amount)
  end

  def expense?
    transaction_type == "expense"
  end

  def income?
    transaction_type == "income"
  end
end
