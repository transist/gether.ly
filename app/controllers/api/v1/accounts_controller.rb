class Api::V1::AccountsController < ApplicationController
  before_filter :authenticate_user!

  def verify_credentials
    render json: current_user
  end
end
