FactoryGirl.define do
  factory :attachment do
    file { fixture_file_upload(Rails.root.join('spec', 'attachments', 'test.png'), 'image/png') }
  end
end
