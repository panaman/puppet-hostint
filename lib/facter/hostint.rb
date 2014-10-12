ktype = (Facter.value('Kernel'))
Facter.add(:hostint) do
  if ktype == 'FreeBSD'
    setcode do
      Facter::Util::Resolution.exec("netstat -f inet -rn | awk '$1==\"default\" { print $6 }'")
    end
  elsif ktype == 'Darwin'
    setcode do
      Facter::Util::Resolution.exec("netstat -f inet -rn | awk '$1==\"default\" { print $6 }'")
    end
  elsif ktype == 'Linux'
    setcode do
      Facter::Util::Resolution.exec("netstat -rn | awk '$1==\"0.0.0.0\" { print $8 }'")
    end
  elsif ktype == 'windows'
    setcode { 'local_area_connection' }
  else 
    setcode { 'UNKNOWN' }
  end
end

Facter.add(:hostint_ipv4) do
  confine :kernel => %w{Linux Darwin FreeBSD}
  int=Facter.value('hostint')
  setcode do
    Facter.value("ipaddress_#{int}")
  end
end

Facter.add(:hostint_dns) do
  confine :kernel => %w{Linux Darwin FreeBSD}
  setcode do
    if File.exists? "/usr/bin/nmcli"
      int  = Facter.value('hostint')
      tool = Facter::Util::Resolution.exec("/usr/bin/nmcli dev list iface #{int}").split(/\n/)
      dns  = tool.select { |name| name[/IP4.DNS[1]:/i] }
      val  = dpx.join.strip.gsub('IP4.DNS[1]:', '')
      if val.nil? || val.empty?
        nil
      else
        "#{val}"
      end
    elsif File.exists? "/etc/resolv.conf"
      Facter::Util::Resolution.exec("cat /etc/resolv.conf | grep nameserver | awk '{print $2}' | head -1")
    else 
      nil
    end
  end
end
   
Facter.add(:hostint_duplex) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? "/sbin/ethtool"
      int  = Facter.value('hostint') 
      tool = Facter::Util::Resolution.exec("ethtool #{int}").split(/\n/)
      dpx  = tool.select { |name| name[/Duplex/i] }
      val  = dpx.join.strip.gsub('Duplex: ', '')
      if val.nil? || val.empty?
        'unknown'
      else
        "#{val}"
      end
    else
     'INSTALL ETHTOOL'
    end
  end
end

Facter.add(:hostint_speed) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? "/sbin/ethtool"
      int  = Facter.value('hostint')
      tool = Facter::Util::Resolution.exec("ethtool #{int}").split(/\n/)
      spd  = tool.select { |name| name[/Speed/i] }
      val  = spd.join.strip.gsub('Speed: ', '')
      if val.nil? || val.empty?
        'unknown'
      else
        "#{val}"
      end
    else
     'INSTALL ETHTOOL'
    end
  end
end

Facter.add(:hostint_gw) do
  if ktype == 'FreeBSD'
    setcode do
      Facter::Util::Resolution.exec("route -n get default |grep gateway|awk '{print $2}'")
    end
  elsif ktype == 'Darwin'
    setcode do
      Facter::Util::Resolution.exec("route -n get default |grep gateway|awk '{print $2}'")
    end
  elsif ktype == 'Linux'
    setcode do
      Facter::Util::Resolution.exec("ip route | grep default | awk '{print $3}'")
    end
  else
    setcode { 'UNKNOWN' }
  end
end
if ktype == 'windows' then
  nm = Facter.value('netmask_local_area_connection')
  Facter.add(:netmask) do
    setcode { nm }
  end
else
end
