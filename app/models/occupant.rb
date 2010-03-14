class Occupant < ActiveRecord::Base
  has_many :devices

#      t.column :nickname, :string
#      t.column :prefix, :string
#      t.column :title, :string
#      t.column :description, :string
#      t.column :email, :string
#      t.column :pass, :string    #hash

  def is_ip_registered?(name, ip)
    search = Occupant.find(:first, ["nickname = ?", name])
    result = (search.device.ip == ip)
  end

  def is_hash_registered? hashcode
    found = false
    search = Occupant.find(:all)
    search.each do |o|
      result = o.device.mac + salt
      found = true  if result == hashcode
    end
    found
  end

  def is_email_registered? email
    search = Occupant.find(:first, ["email = ?", email])
    found = false
    found = true if search
    found
  end

  def hash_from email
  end

end
