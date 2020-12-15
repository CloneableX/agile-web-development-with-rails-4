class StoreController < ApplicationController
  include AccessCounter, CurrentCart

  before_action :increase_times, only: [:index]
  before_action :set_start

  def index
    @products = Product.order(:title)
  end
end
