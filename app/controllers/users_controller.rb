# frozen_string_literal: true

class UsersController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new
  end

  def login; end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user
      flash[:success] = 'welcome to the sample app'
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
