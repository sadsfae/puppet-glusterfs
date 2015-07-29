require 'facter'
Facter.add(:glance_active) do
  setcode "/usr/sbin/gluster volume status glance_vol | grep Status | wc -l"
end
