require 'facter'
Facter.add(:cinder_active) do
  setcode "/usr/sbin/gluster volume status cinder_vol | grep Status | wc -l"
end
