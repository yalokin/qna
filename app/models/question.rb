class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments
end
