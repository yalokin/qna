class AddAnswersToUser < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :answers, :user, index: true
  end
end
