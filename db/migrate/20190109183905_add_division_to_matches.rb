class AddDivisionToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :division, :integer
  end
end
