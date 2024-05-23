class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content, default: 'content will be here'
      t.integer :status

      t.timestamps
    end
  end
end
