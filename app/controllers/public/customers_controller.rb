class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes
    @favorite_recipes = @customer.favorite_recipes
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to root_path
  end

  def unsubscribe
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
end
