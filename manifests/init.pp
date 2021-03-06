# File::      <tt>init.pp</tt>
# Author::    S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team (hpc-sysadmins@uni.lu)
# Copyright:: Copyright (c) 2016 S. Varrette, H. Cartiaux, V. Plugaru, S. Diehl aka. UL HPC Management Team
# License::   Gpl-3.0
#
# ------------------------------------------------------------------------------
# = Class: rclocal
#
# Configure the rc.local file
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of rclocal
#
# == Actions:
#
# Install and configure rclocal
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     include 'rclocal'
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'rclocal':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class rclocal(
    $ensure = $rclocal::params::ensure
) inherits rclocal::params
{
    info ("Configuring rclocal (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("rclocal 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        'debian', 'ubuntu':         { include ::rclocal::debian }
        'redhat', 'fedora', 'centos', 'Amazon': { include ::rclocal::redhat }
        default: {
            fail("Module ${module_name} is not supported on $::{operatingsystem}")
        }
    }
}



