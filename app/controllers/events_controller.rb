class EventsController < ApplicationController

  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :event_must_have_signup_ability, :only => [:signup, :register]

  # GET /events
  # GET /events.xml
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.without_image.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end

  def image
    @event = Event.find(params[:id])

    if @event.image.blank?
      send_file(File.join(Rails.root, 'public', 'images', 'noimage.gif'), :type => 'image/gif')
    else
      send_data(@event.image)
    end
  end

  def signup
    @user    = User.new
    if @event.allow_teams?
      @team    = Team.new
      @partner = User.new
    end 
  end

  def register
    @user  = User.find_by_name_and_email(params[:user][:name], params[:user][:email]) || User.new(params[:user])

    if @event.allow_teams?
      @partner  = User.find_by_name_and_email(params[:partner][:name], params[:partner][:email]) || User.new(params[:partner])
      @team     = Team.find_by_name(params[:team][:name]) || Team.new(params[:team])
    end

    notices = []
    begin
      ActiveRecord::Base.transaction do
        if team_submitted?
          @team.event = @event
          @team.save!
        end

        @user.save!
        if uet = @user.register_for(@event, @team)
          notices << "You are now registered for '#{uet.event.name}'!"
          notices << "Team: #{uet.team.name}" if uet.team_id
        end

        if partner_submitted?
          @partner.save!
          if uet = @partner.register_for(@event, @team)
            notices << "#{uet.user.name} is now registered for '#{uet.event.name}'!"
            notices << "Team: #{uet.team.name}" if uet.team_id
          end
        end
      end
    rescue => e
      @user.valid?
      if team_submitted?
        @team.valid?
        @team.errors.full_messages.each do |err|
          @user.errors.add(:base, "Team #{err}")
        end
      end
      if partner_submitted?
        @partner.valid?
        @partner.errors.full_messages.each do |err|
          @user.errors.add(:base, "Partner #{err}")
        end
      end
      render(:action => 'signup')
      return
    end
    notices << "Thank you for registering!"
    redirect_to(home_path, :notice => notices)
  end

  private
  def team_submitted?
    team = params[:team]
    !team.blank? && (!team[:name].blank? || partner_submitted?)
  end

  def partner_submitted?
    partner = params[:partner]
    !partner.blank? && (!partner[:name].blank? || !partner[:email].blank?)
  end

  def authenticate
    valid_creds = {
      'russ'   => 'Hello!23',
      'hannon' => 'Hello!23'
    }

    authenticate_or_request_with_http_basic do |user, pass|
      bool = false
      valid_creds.each do |key, value|
        bool = true if key == user && value == pass
      end
      bool
    end
  end

  def event_must_have_signup_ability
    @event = Event.find(params[:id])
    redirect_to(home_path) unless @event.allow_signup?
  end
end
