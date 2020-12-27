class StoreController < ApplicationController
  include AccessCounter, CurrentCart

  before_action :increase_times, only: [:index]
  before_action :set_start
  skip_before_action :authorize

  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
