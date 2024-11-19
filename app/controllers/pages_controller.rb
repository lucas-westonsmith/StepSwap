class PagesController < ApplicationController
  before_action :authenticate_user!, only: :profile
  def home
  end

  def profile
    
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end
end
