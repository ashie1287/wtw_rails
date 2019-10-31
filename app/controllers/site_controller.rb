class SiteController < ApplicationController

  before_action :recent_events, :only => :index
  before_action :recent_articles, :only => :index

  def index
  end

  def show
    render(params[:id])
  end
end
