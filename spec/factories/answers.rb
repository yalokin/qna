FactoryGirl.define do
  factory :answer do
    body "MyText"
    question
    user

    factory :invalid_answer do
      body nil
    end

  end
end
