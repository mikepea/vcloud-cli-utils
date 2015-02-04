vcloud-cli-utils
================

Simple CLI utils to talk to the vCloud Director API

These are very hacky utils that I've found handy whilst helping develop
a more rich toolchain for GOV.UK:

* https://github.com/alphagov/vcloud-core
* https://github.com/alphagov/vcloud-edge_gateway
* https://github.com/alphagov/vcloud-tools
* https://github.com/alphagov/vcloud-walker

... which in turn depend on the vcloud_director provider in Fog:

* https://github.com/fog/fog

If you find any of these utilities useful, please let me know, so a sured up
version can be created.

The tools
----

### vcloud-get-entity

Designed to retrieve a complete entity from vCloud via the Fog request layer. Useful
for seeing what is available from the raw requests, as Fog sees it (which can
be slightly, or completely, different from the raw XML returned from the API).

    bx vcloud-get-entity {entity} {entity_id}

{entity} can be 'vm', 'vApp', 'orgVdc', 'edgeGateway', etc. Or alternatively,
any fog service request that takes a single ID as a parameter (eg
'get_vm_capabilities')

### vcloud-curl

Wrapper around curl to use Fog credentials & vcloud-login. Very useful for
getting the complete XML response from the API, for comparison against the data
returned by the Fog request layer

### vcloud-delete-vapp

Deletes a vApp by name or id. --force option stops the vApp first, as vCloud
sensibly prevents running vApps from being deleted.

### vcloud-delete-disk

Deletes an Independent Disk by ID.

### vcloud-delete-network

Deletes an orgVdcNetwork by ID

### vcloud-attach-disk

Attaches an independent disk to a stopped or running VM.

NB: To create a disk, see vcloud-disk_launcher Gem/tool.

### vcloud-detach-disk

Detaches an independent disk from a stopped or running VM. NB: this can cause
problems within the guest OS - beware!

### vcloud-start-vapp

Start a stopped vApp by name or ID.

### vcloud-stop-vapp

Stop a started vApp by name or ID.
