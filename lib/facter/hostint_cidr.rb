Facter.add(:hostint_ipv4_cidr) do
  confine :kernel => %w{Linux Darwin FreeBSD}
  int=Facter.value('hostint')
  setcode do
    network = Facter.value("network_#{int}")
    mask = Facter.value("netmask_#{int}")
    if mask == '255.255.255.255'
      "#{network}/32"
    elsif mask == '255.255.255.254'
      "#{network}/31"
    elsif mask == '255.255.255.252'
      "#{network}/30"
    elsif mask == '255.255.255.248'
      "#{network}/29"
    elsif mask == '255.255.255.240'
      "#{network}/28"
    elsif mask == '255.255.255.224'
      "#{network}/27"
    elsif mask == '255.255.255.192'
      "#{network}/26"
    elsif mask == '255.255.255.128'
      "#{network}/25"
    elsif mask == '255.255.255.0'
      "#{network}/24"
    elsif mask == '255.255.254.0'
      "#{network}/23"
    elsif mask == '255.255.252.0'
      "#{network}/22"
    elsif mask == '255.255.248.0'
      "#{network}/21"
    elsif mask == '255.255.240.0'
      "#{network}/20"
    elsif mask == '255.255.224.0'
      "#{network}/19"
    elsif mask == '255.255.192.0'
      "#{network}/18"
    elsif mask == '255.255.128.0'
      "#{network}/17"
    elsif mask == '255.255.0.0'
      "#{network}/16"
    elsif mask == '255.254.0.0'
      "#{network}/15"
    elsif mask == '255.252.0.0'
      "#{network}/14"
    elsif mask == '255.248.0.0'
      "#{network}/13"
    elsif mask == '255.240.0.0'
      "#{network}/12"
    elsif mask == '255.224.0.0'
      "#{network}/11"
    elsif mask == '255.192.0.0'
      "#{network}/10"
    elsif mask == '255.128.0.0'
      "#{network}/9"
    elsif mask == '255.0.0.0'
      "#{network}/8"
    elsif mask == '254.0.0.0'
      "#{network}/7"
    elsif mask == '252.0.0.0'
      "#{network}/6"
    elsif mask == '248.0.0.0'
      "#{network}/5"
    elsif mask == '240.0.0.0'
      "#{network}/4"
    elsif mask == '224.0.0.0'
      "#{network}/3"
    elsif mask == '192.0.0.0'
      "#{network}/2"
    elsif mask == '128.0.0.0'
      "#{network}/1"
    elsif mask == '0.0.0.0'
      "#{network}/0"
    else 
      nil
    end
  end
end
