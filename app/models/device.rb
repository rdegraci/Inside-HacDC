class Device < ActiveRecord::Base
  belongs_to :occupant

#      t.column :status, :string
#      t.column :ipaddress, :string
#      t.column :machineaddress, :string
#      t.column :name, :string

  def self.is_online? ip
    search = Device.find(:first, ["ipaddress = ?", ip])
    if search == nil then
      return false
    end
    return true
  end

  def self.exists? mac 
    search = Device.find(:first, ["machineaddress = ?", mac])
    if search == nil then
      return false
    end
    return true
  end

  def self.offline mac
    search = Device.find(:first,["machineaddress = ?", mac])
    search.each do |d|
      d.status = "offline"
      d.save
    end
  end

  def self.online mac
    search = Device.find(:first,["machineaddress = ?", mac])
    search.each do |d| 
      d.status = "online"
      d.save
    end
  end
 
  def self.status_update statusline

    #192.168.0.1,00:1D:7E:BD:FA:EA,(Cisco-Linksys);192.168.0.108,00:A0:12:0C:EF:92,(B.a.t.m. Advanced Technologies);192.168.0.109,00:0B:82:04:E6:2A,(Grandstream Networks);
  
    line = statusline.chomp ';'

    records = line.split /;/

    records.each do |r|
      fields = r.split /,/
    
      ip = fields[0]
      mac = fields[1]
      name = fields[2]

      if Device.exists?(mac) == false then
        device = Device.new
        device.ip = ip
        device.mac = mac
        device.name = name
        device.status = "online"
        device.save
      else 
        search = Device.find(:first, ["machineaddress = ?", mac])
        search.each do |d| 
          d.ip = ip
          d.status = "online"
	  d.save
        end
      end
    end
  end
  
end
