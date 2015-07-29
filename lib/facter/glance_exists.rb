require 'facter'
Facter.add(:glance_exists) do
  setcode "/usr/sbin/gluster volume info glance_vol | grep glance_vol | wc -l"
end
