require 'facter'
Facter.add(:glance_device_id) do
  setcode "/sbin/blkid /dev/vg_`hostname -s`_glfs/lv_glance | awk '{print $2}'"
end
