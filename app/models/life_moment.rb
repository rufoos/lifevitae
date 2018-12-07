class LifeMoment < ApplicationRecord
  has_many :strengths, class_name: 'LifeMomentStrength'

  default_scope -> { order('sort ASC') }

  def strengths=(strength_names)
    if new_record?
      strengths.build(strength_names.map { |name| { name: name } })
    else
      existed_strengths = strengths.pluck(:id, :name)
      existed_strengths_names = existed_strengths.map { |(_id, name)| name }
      strengths_for_destroy = existed_strengths.select { |(_id, name)| !strength_names.include?(name) }
      strengths_for_create = strength_names.select { |name| !existed_strengths_names.include?(name) }

      unless strengths_for_destroy.empty?
        LifeMoment.destroy(strengths_for_destroy.map { |(id, _name)| id })
      end

      unless strengths_for_create.empty?
        strengths.create(strengths_for_create.map { |name| { name: name } })
      end
    end
  end
end
