class Api::V1::EventsController < ApplicationController
  before_filter :authenticate_user!, except: [:accept, :decline]
  before_filter :load_token, only: [:accept, :decline]

  def create
    event = Event.create(params[:event])
    invitations_hash = params[:invitations]
    invitations_hash.each{|invitation| event.invitations << Invitation.create(invitation)}
    current_user.created_hosts << event
    event.invitations.each{|invitation| invitation.mail}
    render json: event
  end

  def accept
    @invitation.accept if @invitation && @invitation.sent?
    render text: 'Thank you for acceptting this.'
  end

  def decline
    @invitation.decline if @invitation && @invitation.sent?
    render text: 'Maybe next time!'
  end

  def index
    render json: current_user.created_hosts
  end

  def invitations
    @event = Event.find params[:id]
    render json: @event.invitations
  end

  protected
  def load_token
    @event = Event.find params[:id]
    token = params[:token]
    @invitation = Invitation.where(token: token).first
  end
end
