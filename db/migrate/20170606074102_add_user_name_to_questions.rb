class AddUserNameToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :user_name, :string
  end
end
