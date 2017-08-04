module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
  end

  def vote(user, value)
    return if voted?(user)

    if value == 1
      transaction do
        votes.create!(user: user, value: value)
        self.class.increment_counter(:rating, self)
        reload
      end
    elsif value == -1
      transaction do
        votes.create!(user: user, value: value)
        self.class.decrement_counter(:rating, self)
        reload
      end
    end

  end

  def cancel_vote(user)
    return unless voted?(user)

    transaction do
      if vote_by(user).value == 1
        self.class.decrement_counter(:rating, self)
      else
        self.class.increment_counter(:rating, self)
      end
      reload
      vote_by(user).destroy
    end
  end

  def vote_by(user)
    votes.find_by(user: user)
  end

  private

  def voted?(user)
    user.votes.exists?(votable: self)
  end
end