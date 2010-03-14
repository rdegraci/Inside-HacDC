class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.column :plaintext, :string
      t.column :nickname, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
