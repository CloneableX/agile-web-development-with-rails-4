class StoreController < ApplicationController
  include AccessCounter

  before_action :increase_times, only: [:index]

  def index
    @products = Product.order(:title)
  end
end
