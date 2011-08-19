class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer :id
     # t.integer :labelnumber
      t.string :group
      t.string :subgroup
      #t.timestamps
      
      ### use only integer /string/text-for lots of data/boolean
    end
  end

  def self.down
    drop_table :categories
  end
end
