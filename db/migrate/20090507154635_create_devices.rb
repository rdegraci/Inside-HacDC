class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.column :ipaddress, :string
      t.column :machineaddress, :string
      t.column :name, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
