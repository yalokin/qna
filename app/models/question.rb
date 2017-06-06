class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  validates :title, :body, :user_name, presence: true
end
