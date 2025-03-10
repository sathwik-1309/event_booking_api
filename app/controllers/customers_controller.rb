class CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    
    if customer.save
      token = JsonWebToken.encode(user_id: customer.id, role: 'Customer')
      render json: { token: token, role: 'Customer' }, status: :created
    else
      render json: { error: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end