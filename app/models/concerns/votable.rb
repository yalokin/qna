module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote(user, direction)
    if direction == 'up'
      transaction do
        votes.create!(user: user, value: 1)
        increment!(:rating, 1)
      end
    else
      transaction do
        votes.create!(user: user, value: -1)
        decrement!(:rating, 1)
      end
    end
  end
end