class CreateOccupants < ActiveRecord::Migration
  def self.up
    create_table :occupants do |t|
      t.column :nickname, :string
      t.column :prefix, :string
      t.column :title, :string
      t.column :description, :string
      t.column :email, :string
      t.column :pass, :string    #hash
      t.timestamps
    end
  end

  def self.down
    drop_table :occupants
  end
end
