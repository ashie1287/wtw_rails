class TeamsController < ApplicationController

  before_filter :authenticate

  def index
    @event = Event.find(params[:event_id])
    @teams = @event.teams
  end

  def show
    @event = Event.find(params[:event_id])
    @team = @event.teams.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @team = @event.teams.build
  end

  def edit
    @event = Event.find(params[:event_id])
    @team = @event.teams.find(params[:id])
  end

  def create
    @event = Event.find(params[:event_id])
    @team = @event.teams.build

    if @team.save
      redirect_to(event_team_path(@event, @team), :notice => 'Team was successfully created.')
    else
      render :action => "new" 
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @team = @event.teams.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to(event_team_path(@event, @team), :notice => 'Team was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @team = @event.teams.find(params[:id])
    @team.destroy

    redirect_to(event_teams_url(@event))
  end
end
