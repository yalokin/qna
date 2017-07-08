class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable

  validates :body, presence: true

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order(best: :desc) }

  def best!
    prev_best = question.answers.where(best: true)
    transaction do
      prev_best.update(best: false) unless prev_best.empty?
      update!(best: true)
    end
  end
end
