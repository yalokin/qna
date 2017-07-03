class AddUniqBestIndexToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_index :answers, [:best, :question_id], unique: true, name: 'one_best_answer', where: 'best IS TRUE'
  end
end