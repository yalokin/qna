FactoryGirl.define do
  factory :answer do
    body "MyText"
    question

    factory :invalid_answer do
      body nil
    end

  end
end
