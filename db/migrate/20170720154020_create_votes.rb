class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :votable, polymorphic: true, index: true
      t.column :value, :integer, default: 0
      t.timestamps
    end
  end
end
