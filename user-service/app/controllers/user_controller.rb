class UserController < ApplicationController
  before_action :user

  USERS = [
    {'id' => 1, 'first_name' => 'Michael', 'last_name' => 'Scott', 'position' => 'Regional Manager', 'role' => 'admin', 'time_zone' => 'America/New_York'},
    {'id' => 2, 'first_name' => 'Jim', 'last_name' => 'Halpert', 'position' => 'Salesperson', 'role' => 'user', 'time_zone' => 'America/Detroit'},
    {'id' => 3, 'first_name' => 'Pam', 'last_name' => 'Beesly', 'position' => 'Receptionist', 'role' => 'user', 'time_zone' => 'America/Denver'},
    {'id' => 4, 'first_name' => 'Dwight', 'last_name' => 'Schrute', 'position' => 'Salesperson', 'role' => 'user', 'time_zone' => 'America/Chicago'},
    {'id' => 5, 'first_name' => 'Anglea', 'last_name' => 'Martin', 'position' => 'Accountant', 'role' => 'user', 'time_zone' => 'America/Los_Angeles'},
  ]

  def show
    if @user then
      render json: { "id": @user["id"], "first_name": @user["first_name"], "last_name": @user["last_name"] }
    else
      render json: { "message": "User not found" }, status: :not_found
    end
  end

  def all_users
    if @user
      if @user["role"] == "admin"
        render json: USERS.map{ |f| [ "id": f["id"], "first_name": f["first_name"], "last_name": f["last_name"], "position": f["position"]] }
      else
        render json: { "message": "User does not have sufficient privileges to view this data." }, status: :bad_request
      end
    else
      render json: { "message": "User not found" }, status: :not_found
    end
  end

  private

  def user
    @user ||= USERS.find{ |x| x["id"] == params[:user_id].to_i }
  end
end
