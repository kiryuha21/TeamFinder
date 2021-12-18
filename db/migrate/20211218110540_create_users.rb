class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :real_name
      t.string :nickname
      t.string :password_digest
      t.datetime :last_login

      t.timestamps
    end
    add_index :users, :nickname, unique: true
  end
end
