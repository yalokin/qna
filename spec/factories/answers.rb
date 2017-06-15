FactoryGirl.define do
  sequence :body_answer do |n|
    "MyText #{n}"
  end

  factory :answer do
    body :body_answer
    question
    user

    factory :invalid_answer do
      body nil
    end

  end
end
