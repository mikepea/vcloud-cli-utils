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

### vcloud-vapp-delete

Deletes a vApp by name or id. --force option stops the vApp first, as vCloud
sensibly prevents running vApps from being deleted.


