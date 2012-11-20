class Api::V1::EventsController < ApplicationController
  def create
    event = Event.create(params[:event])
    render json: event
  end
end
