class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.datetime :start
      t.integer :duration

      t.timestamps null: false
    end
  end
end
