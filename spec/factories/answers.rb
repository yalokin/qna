FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "MyText #{n}" }
    question
    user

    factory :invalid_answer do
      body nil
    end
  end
end
