require 'net/http'
require 'uri'
class Users::SessionsController < Devise::SessionsController
  def create
    super do |resource|
      # Generate and save the verify_token upon successful sign-in
      resource.generate_and_save_verify_token if resource.persisted?
      session[:user] = "52"
    end
  end

  def destroy
    super
    p ":::::::>>>>>>>#{cookies[:user]}"
    reset_session
    invalidate_child_session
  end
  private

  def invalidate_child_session
    p ":::::::::logout called::::::"
    
    # user_id = current_user.id  # Assuming you have a `current_user` method
    verify_url = URI('http://localhost:3000/reset_user_session')  # Replace with child app's endpoint
    http = Net::HTTP.new(verify_url.host, verify_url.port)
    response = http.request(Net::HTTP::Delete.new(verify_url))
  end
end
