class CreateTestUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :test_users do |t|
      t.string :user_id
      t.string :title
      t.text :body

      t.timestamps
    end

    add_index :test_users, :user_id, unique: true
  end
end
