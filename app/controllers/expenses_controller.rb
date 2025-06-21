class ExpensesController < ApplicationController
  def index
    @today_expenses = Expense.expenses.for_date(Date.current).recent
    @today_income = Expense.income.for_date(Date.current).recent
    @daily_expense_total = Expense.daily_expense_total
    @daily_income_total = Expense.daily_income_total
    @monthly_expense_total = Expense.monthly_expense_total
    @monthly_income_total = Expense.monthly_income_total
    @category_totals = Expense.expense_category_totals.first(3)
    @income_category_totals = Expense.income_category_totals.first(3)
    @monthly_trends = Expense.monthly_trend(6)
    @recent_expenses = Expense.expenses.recent.limit(10)
    @recent_income = Expense.income.recent.limit(5)
    @categories = Category.all
    @expense_categories = Category.where(name: [ "Food", "Transportation", "Household", "Rent", "Shopping", "Materials", "Train" ])
    @income_categories = Category.where(name: [ "Salary", "Freelance", "Investment", "Business", "Gift", "Other" ])
    @new_expense = Expense.new
    @net_worth = Expense.net_worth
  end

  def all
    @transactions = Expense.includes(:category_ref).recent
    @expenses = @transactions.expenses
    @income = @transactions.income
    @total_expenses = @expenses.sum(:amount)
    @total_income = @income.sum(:amount)
    @net_worth = @total_income - @total_expenses
    @categories = Category.all

    # Group transactions by month for better organization
    @transactions_by_month = @transactions.group_by { |transaction| transaction.date.beginning_of_month }
  end

  def new
    @expense = Expense.new
    @expense.transaction_type = params[:type]&.in?([ "expense", "income" ]) ? params[:type] : "expense"
    @categories = Category.all
    @expense_categories = Category.where(name: [ "Food", "Transportation", "Household", "Rent", "Shopping", "Materials", "Train" ])
    @income_categories = Category.where(name: [ "Salary", "Freelance", "Investment", "Business", "Gift", "Other" ])
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_name = "Jenny Yu" # For demo purposes
    @expense.date = Date.current unless @expense.date.present?

    if @expense.save
      redirect_to root_path, notice: "#{@expense.transaction_type.capitalize} was successfully created."
    else
      @categories = Category.all
      @expense_categories = Category.where(name: [ "Food", "Transportation", "Household", "Rent", "Shopping", "Materials", "Train" ])
      @income_categories = Category.where(name: [ "Salary", "Freelance", "Investment", "Business", "Gift", "Other" ])
      render :new, status: :unprocessable_entity
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:description, :amount, :category, :date, :transaction_type)
  end
end
