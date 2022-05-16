class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:guest_sign_in]
  before_action :ensure_customer, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes.page(params[:page])
    @favorite_recipes = @customer.favorite_recipes.page(params[:page])
  end

  def edit
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "ユーザー情報を編集しました"
    else
      render :edit
    end
  end

  def unsubscribe
    if current_customer.name == "guestuser"
      redirect_to customer_path(current_customer)
    end
  end

  def withdraw
    current_customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会が完了しました"
  end

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: "ゲストログインしました"
  end

  def index
    redirect_to new_customer_registration_path
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :name, :introduction)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser" || @customer != current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
