class LifeMomentsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    @life_moments = LifeMoment.includes(:strengths).all
  end
end
