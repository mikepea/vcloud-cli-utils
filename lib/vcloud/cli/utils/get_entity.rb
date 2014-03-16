require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class GetEntity
        include Methadone::Main
        include Methadone::CLILogging

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
          else
            puts "Entity #{entity_type} is not recognised"
          end
        end

        arg :entity_type
        arg :identifier

        description "
        "

        go!
      end

    end
  end
end
