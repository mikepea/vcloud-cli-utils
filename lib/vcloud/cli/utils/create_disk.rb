require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class CreateDisk

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |identifier, disk_name, disk_size|
            vcloud = ::Fog::Compute::VcloudDirector.new
            if identifier =~ /^[-0-9a-f]+/
              vdc = Vcloud::Core::Vdc.new(identifier)
            else
              vdc = Vcloud::Core::Vdc.get_by_name(identifier)
            end
            Fog.mock! if ENV['FOG_MOCK']
            puts "Creating disk in #{vdc.id}: #{disk_name} => #{disk_size}"
            body = vcloud.post_create_disk(vdc.id, disk_name, disk_size).body
            vcloud.process_task(body[:Disk][:Tasks])
          end

          arg :identifier
          arg :disk_name
          arg :disk_size

          description "
          "

          go!

        end
      end

    end
  end
end
