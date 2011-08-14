class SiteController < ApplicationController
  def index
    @events = Event.last(8)
  end

  def about
  end
end
