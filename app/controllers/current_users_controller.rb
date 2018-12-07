class CurrentUsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    current_user.update(current_user_params)
    render :show
  end

  private

  def current_user_params
    params.require(:user).permit(
      :fullname,
      :email,
      :gender,
      :birth_date,
      :phone,
      :city_name,
      :looking_for,
      :job_org_name,
      :job_current_role,
      :job_about_desc,
      past_cities: [],
      events: [:id, :name, :year, :event_type],
      skills: [:id, :name],
      achievements: [:name],
      answers: [:life_moment_id, :answer, strengths: []]
    )
  end
end
