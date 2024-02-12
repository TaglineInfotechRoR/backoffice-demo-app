class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def verify_token
    if params[:token].nil?
      render json: { success: false, message: "Token doesn't exist" }
    else
      user = User.find_by(verify_token: params[:token])
      if user.nil?
        render json: { success: false, message: "Token doesn't exist" }
      else
        render json: { success: true, email: user.email, firstname: user.firstname, lastname: user.lastname, message: 'User Found' }
      end
    end
  end
end
