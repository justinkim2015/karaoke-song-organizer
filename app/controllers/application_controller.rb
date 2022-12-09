class ApplicationController < ActionController::Base
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
end
