class CreatePosts < ActiveRecord::Migration

	def change 
		create_table :posts do |l|
	    l.integer :user_id
      l.string :post_text
      l.timestamps null: false
 	 end
	end
end