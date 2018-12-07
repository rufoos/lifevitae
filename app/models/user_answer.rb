class UserAnswer < ApplicationRecord
  belongs_to :life_moment
  belongs_to :user
  has_many :strengths, class_name: 'UserAnswerStrength'

  def strengths=(strengths_names)
    return if strengths_names.nil?
    strengths.destroy_all unless strengths.empty?
    collection =
      strengths_names.map do |name|
        { name: name }
      end
    strengths.build(collection)
  end
end
