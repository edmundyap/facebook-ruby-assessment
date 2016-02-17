class CreateComments < ActiveRecord::Migration

	def change 
		create_table :comments do |l|
			l.integer :user_id
			l.integer :question_id
			l.string :comment_text
			l.timestamps null: false
		end
	end
end