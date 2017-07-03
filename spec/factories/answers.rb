FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "MyAnswer #{n}" }
    question
    user

    factory :invalid_answer do
      body nil
    end

    factory :best_answer do
      best true
    end

  end
end
