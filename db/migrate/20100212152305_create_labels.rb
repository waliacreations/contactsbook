class CreateLabels < ActiveRecord::Migration
  def self.up
    create_table :labels do |t|
      t.integer :id
      t.string :labelcategory
      t.string :labeldetails
      t.integer :labelnumber
      t.string :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :labels
  end
end
