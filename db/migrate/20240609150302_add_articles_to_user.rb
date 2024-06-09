class AddArticlesToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :articles, null: true, foreign_key: true
  end
end
