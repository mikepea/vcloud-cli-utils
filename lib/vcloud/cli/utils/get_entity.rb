require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class GetEntity

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |entity_type, identifier|
            vcloud = ::Fog::Compute::VcloudDirector.new
            case entity_type
            when 'vm'
              pp vcloud.get_vapp(identifier).body
            when 'vApp'
              pp vcloud.get_vapp(identifier).body
            when 'edgeGateway'
              pp vcloud.get_edge_gateway(identifier).body
            when 'orgVdcNetwork'
              pp vcloud.get_network_complete(identifier).body
            when 'orgVdc'
              pp vcloud.get_vdc(identifier).body
            when /^get_/
              pp vcloud.send(entity_type.to_s, identifier).body
            else
              help_now!("Invalid argument #{entity_type}")
            end
          end

          arg :entity_type
          arg :identifier

          description "
vcloud-get-entity retreives the raw Fog body for key entity types in vCD.

It can also call any Fog request method beginning with 'get_', that takes a single
argument -- generally the id of the entity. There are many of these.

Supported entities can usually be retreived by name as well:

   * vm
   * vApp
   * edgeGateway
   * orgVdcNetwork
   * orgVdc

"

          go!

        end
      end

    end
  end
end
