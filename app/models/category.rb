class Category < ApplicationRecord
  has_many :expenses, foreign_key: "category_ref_id", dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  validates :icon, presence: true

  def total_amount
    expenses.sum(:amount)
  end

  def monthly_amount(month = Date.current.month, year = Date.current.year)
    expenses.for_month(month, year).sum(:amount)
  end
end
