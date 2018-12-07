class LifeEventsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    @life_events = LifeEvent.with_user(current_user).all
  end
end
