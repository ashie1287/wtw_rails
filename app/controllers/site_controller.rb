class SiteController < ApplicationController
  def index
    @events = Event.order('created_at').limit(5).reverse_order
  end

  def about
  end
end
