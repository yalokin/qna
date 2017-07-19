class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order(best: :desc) }

  include Attachable

  def best!
    prev_best = question.answers.where(best: true).first
    transaction do
      prev_best&.update!(best: false)
      update!(best: true)
    end
  end
end
