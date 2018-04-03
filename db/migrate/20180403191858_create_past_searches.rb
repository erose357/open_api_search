class CreatePastSearches < ActiveRecord::Migration
  def change
    create_table :past_searches do |t|
      t.references :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
