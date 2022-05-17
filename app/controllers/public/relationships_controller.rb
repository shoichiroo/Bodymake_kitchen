class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    follow = current_customer.active_relationships.build(follower_id: params[:customer_id])
    follow.save
    redirect_to request.referer
  end

  def destroy
    follow = current_customer.active_relationships.find_by(follower_id: params[:customer_id])
    follow.destroy
    redirect_to request.referer
  end

  def follows
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings
  end

  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers
  end
end
