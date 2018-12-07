if user_signed_in?
  json.extract! current_user, :id, :email, :fullname, :phone, :gender, :city_name, :looking_for, :job_current_role, :job_org_name, :job_about_desc
  json.birth_date current_user.birth_date&.strftime('%Y-%m-%d')
  json.past_cities current_user.past_cities&.map(&:city_name)
  json.events current_user.events do |user_event|
    json.id user_event.life_event_id
    json.name user_event.life_event.name
    json.year user_event.year
    json.event_type user_event.event_type
  end
  json.skills current_user.skills do |user_skill|
    json.id user_skill.life_skill_id
    json.name user_skill.life_skill.name
  end
  json.achievements current_user.achievements do |user_achievement|
    json.name user_achievement.name
  end
  json.answers current_user.answers do |user_answer|
    json.life_moment_id user_answer.life_moment_id
    json.answer user_answer.answer
    json.strengths user_answer.strengths.map(&:name)
  end
end
