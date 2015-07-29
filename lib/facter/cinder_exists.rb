require 'facter'
Facter.add(:cinder_exists) do
  setcode "/usr/sbin/gluster volume info cinder_vol | grep cinder_vol | wc -l"
end
