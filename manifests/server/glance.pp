# setup glance and join existing cluster
class gluster::server::glance {

    # ensure glance directory exists
    file { "/srv/gluster/glance":
        ensure => "directory",
        owner  => "root",
        group  => "root",
        mode   => "0755",
    }

    # ensure glance LV is mounted
    mount { '/srv/gluster/glance':
        device => $::glance_device_id,
        fstype => "xfs",
        ensure => "mounted",
        options => "defaults",
        atboot => "true",
    }
 
    # exec glusterfs command to create glance vol if it doesn't exist, join cluster
    if $glance_exists == "0" {
    
    exec { "gluster create volume glance":
      require => Mount['/srv/gluster/glance'],
      command => "/usr/sbin/gluster volume create glance_vol replica ${replicacount} ${mystorageip}:/srv/gluster/glance ${gluster_server_peers}:/srv/gluster/glance",
    }

 }
    if $glance_active == "0" {

    exec { "gluster volume start glance_vol":
     require => Mount['/srv/gluster/glance'],
     command => "/usr/sbin/gluster volume start glance_vol",
    }

  }

}
