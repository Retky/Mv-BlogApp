class UsersController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user!
    redirect_to '/users/sign_in' unless current_user
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
