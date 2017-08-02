module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote(user, direction)
    return if voted?(user)

    if direction == 'up'
      transaction do
        votes.create!(user: user, value: 1)
        increment!(:rating, 1)
        reload
      end
    else
      transaction do
        votes.create!(user: user, value: -1)
        decrement!(:rating, 1)
        reload
      end
    end
  end

  def cancel_vote(user)
    if voted?(user)
      transaction do
        if vote_for(user).value == 1
          decrement!(:rating, 1)
        else
          increment!(:rating, 1)
        end
        reload
        vote_for(user).destroy
      end
    end
  end

  def vote_for(user)
    votes.where(user: user).first if user
  end

  private

  def voted?(user)
    user.votes.exists?(votable: self)
  end
end