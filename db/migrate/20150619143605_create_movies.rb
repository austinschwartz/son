class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :poster
      t.string :title
      t.integer :upvotes
      t.integer :downvotes
      t.string :imdb_id

      t.timestamps null: false
    end
  end
end
