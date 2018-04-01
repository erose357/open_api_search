FactoryBot.define do
  factory :search do
    sequence :search_term do |n|
      "cyclops #{n}"
    end
    count 1
  end
end
