class HomeController < ApplicationController
  def index
    redirect_to "/tels" if user_signed_in?
  end
end
