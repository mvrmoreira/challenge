FactoryBot.define do
  factory :restaurant do
    name "Eben Ezer"
  end

  factory :culinary do
    name "Italiana"

    transient do
     restaurant_count 0
    end

    after(:create) do |culinary, evaluator|
      create_list(:restaurant, evaluator.restaurant_count, culinaries: [culinary])
    end
  end
end