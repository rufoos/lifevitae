class LifeSkillsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    @life_skills = LifeSkill.with_user(current_user).all
  end
end
