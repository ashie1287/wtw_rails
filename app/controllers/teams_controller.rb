class TeamsController < ApplicationController

  before_action :authenticate
  before_action do
    @event = Event.find(params[:event_id])
  end

  def index
    @teams = @event.teams
  end

  def show
    @team = @event.teams.find(params[:id])
  end

  def new
    @team = @event.teams.build
  end

  def edit
    @team = @event.teams.find(params[:id])
  end

  def create
    @team = @event.teams.build

    if @team.save
      redirect_to(event_team_path(@event, @team), :notice => 'Team was successfully created.')
    else
      render :action => "new" 
    end
  end

  def update
    @team = @event.teams.find(params[:id])

    if @team.update_attributes(params[:team])
      redirect_to(event_team_path(@event, @team), :notice => 'Team was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @team = @event.teams.find(params[:id])
    @team.destroy

    redirect_to(event_teams_url(@event))
  end
end
