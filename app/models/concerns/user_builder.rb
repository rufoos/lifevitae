module UserBuilder
  extend ActiveSupport::Concern

  def past_cities=(city_names)
    if new_record?
      past_cities.build(city_names.map { |city_name| { city_name: city_name } })
    else
      existed_cities = past_cities.pluck(:id, :city_name)
      existed_cities_names = existed_cities.map { |(_id, city_name)| city_name }
      cities_for_destroy = existed_cities.select { |(_id, city_name)| !city_names.include?(city_name) }
      cities_for_create = city_names.select { |city_name| !existed_cities_names.include?(city_name) }

      unless cities_for_destroy.empty?
        UserPastCity.destroy(cities_for_destroy.map { |(id, _)| id })
      end

      unless cities_for_create.empty?
        past_cities.create(cities_for_create.map { |city_name| { city_name: city_name } })
      end
    end
  end

  def events=(params)
    association_params = []
    params.each do |life_event_params|
      if life_event_params[:id].present?
        association_params << {
          life_event_id: life_event_params[:id],
          year: life_event_params[:year],
          event_type: life_event_params[:event_type]
        }
      elsif life_event_params[:name]
        unless LifeEvent.with_user(self).exists?(name: life_event_params[:name])
          life_event = my_events.create(name: life_event_params[:name])
          association_params << {
            life_event_id: life_event.id,
            year: life_event_params[:year],
            event_type: life_event_params[:event_type]
          }
        end
      end
    end

    build_association(events, association_params, [:life_event_id, :year, :event_type])
  end

  def skills=(params)
    association_params = []
    params.each do |life_skill_params|
      if life_skill_params[:id].present?
        association_params << {
          life_skill_id: life_skill_params[:id]
        }
      elsif life_skill_params[:name]
        unless LifeSkill.with_user(self).exists?(name: life_skill_params[:name])
          life_skill = LifeSkill.create(name: life_skill_params[:name], user_id: self.id)
          association_params << {
            life_skill_id: life_skill.id
          }
        end
      end
    end

    build_association(skills, association_params, [:life_skill_id])
  end

  def achievements=(params)
    build_association(achievements, params, [:name])
  end

  def answers=(params)
    build_association(answers, params, [:life_moment_id, :answer, :strengths])
  end

  private

  def build_association(assoc, params, keys)
    return if params.nil?
    assoc.destroy_all unless assoc.empty?
    collection =
      params.map do |assoc_params|
        assoc_params.slice(*keys)
      end
    assoc.build(collection)
  end
end
