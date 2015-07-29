require 'facter'
Facter.add(:cinder_device_id) do
  setcode "/sbin/blkid /dev/vg_`hostname -s`_glfs/lv_cinder | awk '{print $2}'"
end
