class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |l|
      l.string :full_name
      l.string :email
      l.string :password_digest, null: false
      l.timestamps null: false
    end
  end
end