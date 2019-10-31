class ApplicationController < ActionController::Base
  private

  def authenticate
    valid_creds = {
      'russ'   => 'Hello!23',
      'hannon' => 'Hello!23',
      'lisa' => 'Hello!23'
    }

    authenticate_or_request_with_http_basic do |user, pass|
      bool = false
      valid_creds.each do |key, value|
        bool = true if key == user && value == pass
      end
      bool
    end
  end

  def recent_events
    @events = Event.where(["end_time >= ?", Time.zone.now.to_s(:db)]).order('created_at').limit(5).reverse_order
  end

  def recent_articles
    @articles = Article.order('created_at').limit(5).reverse_order
  end
end
