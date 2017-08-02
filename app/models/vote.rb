class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true, optional: true
  belongs_to :user

  validates :value, uniqueness: { scope: [:user_id, :votable_id, :votable_type] }
end