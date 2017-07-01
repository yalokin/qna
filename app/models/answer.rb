class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true
  validates_uniqueness_of :best, conditions: -> { where(best: true) }, scope: :question_id

  def best!
    prev_best = question.answers.where(best: true)
    prev_best.update(best: false)
    update(best: true)
  end
end
