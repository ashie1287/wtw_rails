class SiteController < ApplicationController

  before_filter :recent_events, :only => :index
  before_filter :recent_articles, :only => :index

  def index
  end

  def show
    render(params[:id])
  end
end
