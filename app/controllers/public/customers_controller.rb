class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:guest_sign_in]
  before_action :ensure_guest_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes.page(params[:page])
    @favorite_recipes = @customer.favorite_recipes.page(params[:page])
  end

  def edit
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer)
  end

  def unsubscribe
    if current_customer.name == "guestuser"
      redirect_to customer_path(current_customer)
    end
  end

  def withdraw
    current_customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :name, :introduction)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer)
    end
  end
end
