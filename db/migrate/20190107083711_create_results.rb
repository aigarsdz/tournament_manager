class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.belongs_to :team, index: true
      t.integer :score
      t.belongs_to :match, index: true
      t.timestamps
    end
  end
end
