class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html { redirect_to }
      end
    end
  end
end
