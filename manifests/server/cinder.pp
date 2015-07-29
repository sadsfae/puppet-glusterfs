# setup cinder and join existing cluster
class gluster::server::cinder {

    # ensure cinder dir exists
    file { "/srv/gluster/cinder":
        ensure => "directory",
        owner  => "root",
        group  => "root",
        mode   => "0755"
    }
    
    # ensure cinder LV is mounted
    mount { '/srv/gluster/cinder':
        device => $::cinder_device_id,
        fstype => "xfs",
        ensure => "mounted",
        options => "defaults",
        atboot => "true",
    }
      
    # exec glusterfs command to create cinder vol if it doesn't exist, join cluster
    if $cinder_exists == "0" {

    exec { "gluster create volume cinder":
      require => Mount['/srv/gluster/cinder'],
      command => "/usr/sbin/gluster volume create cinder_vol replica ${replicacount} ${mystorageip}:/srv/gluster/cinder ${gluster_server_peers}:/srv/gluster/cinder",
    }

  }

    if $cinder_active == "0" {

    exec { "gluster volume start cinder_vol":
     require => Mount['/srv/gluster/cinder'],
     command => "/usr/sbin/gluster volume start cinder_vol",
    }

  }

}
