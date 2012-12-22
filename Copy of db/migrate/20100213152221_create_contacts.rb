class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :id
      t.integer :contactid
      t.integer :labelnumber
      t.string :labeldetails
      t.string :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
