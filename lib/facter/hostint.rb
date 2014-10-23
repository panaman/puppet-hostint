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
      Facter::Util::Resolution.exec("ip route | grep default | awk '{print $5}'") 
    end
  elsif ktype == 'windows'
    setcode { 'local_area_connection' }
  else 
    setcode { 'UNKNOWN' }
  end
end

Facter.add(:hostint_ipv4) do
  confine :kernel => %w{Linux Darwin FreeBSD}
  if ktype == 'FreeBSD'
    setcode do
      int = Facter::Util::Resolution.exec("netstat -f inet -rn | awk '$1==\"default\" { print $6 }'")
      Facter.value("ipaddress_#{int}")
    end
  elsif ktype == 'Darwin'
    setcode do
      int = Facter::Util::Resolution.exec("netstat -f inet -rn | awk '$1==\"default\" { print $6 }'")
      Facter.value("ipaddress_#{int}")
    end
  elsif ktype == 'Linux'
    setcode do
      int = Facter::Util::Resolution.exec("ip route | grep default | awk '{print $5}'")
      Facter.value("ipaddress_#{int}")
    end
  end
end

Facter.add(:hostint_dns) do
  confine :kernel => %w{Linux Darwin FreeBSD}
  setcode do
    if File.exists? "/etc/resolv.conf"
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
      int = Facter.value('hostint') 
      tool = Facter::Util::Resolution.exec("ethtool #{int} | grep Duplex")
      val = tool.strip.gsub('Duplex: ', '')
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
      int = Facter.value('hostint')
      tool = Facter::Util::Resolution.exec("ethtool #{int} | grep Speed")
      val = tool.strip.gsub('Speed: ', '')
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
