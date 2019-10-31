class EventsController < ApplicationController

  before_action :authenticate, :except => [:show, :signup, :register]
  before_action :event_must_have_signup_ability, :only => [:signup, :register]

  def users
    @event = Event.find(params[:id])
    @users = @event.users
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      redirect_to(@event, :notice => 'Event was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to(@event, :notice => 'Event was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to(events_url)
  end

  def remove_image
    @event = Event.find(params[:id])
    @event.remove_image
    redirect_to({:action => :edit}, :notice => 'Image successfully removed from event.')
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

  def event_must_have_signup_ability
    @event = Event.find(params[:id])
    redirect_to(home_path) unless @event.allow_signup?
  end
end
