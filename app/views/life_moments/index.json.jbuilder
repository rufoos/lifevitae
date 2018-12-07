json.array! @life_moments do |life_moment|
  json.id life_moment.id
  json.main_question life_moment.main_question
  json.strengths do
    json.array! life_moment.strengths.map(&:name)
  end
end
