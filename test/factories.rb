FactoryBot.define do
  factory :restaurant do
    name "Eben Ezer"
  end

  factory :inventory do
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

  factory :reservation do
    name "Ebenezio Meche a Perna"
    email "ebenezio@email.com"
    phone "1599881515"
    seats 2
    event_time DateTime.now
  end
end