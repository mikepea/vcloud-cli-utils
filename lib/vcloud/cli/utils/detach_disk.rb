require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class DetachDisk

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |vm_id, disk_id|
            vcloud = ::Fog::Compute::VcloudDirector.new
            Fog.mock! if ENV['FOG_MOCK']
            task = vcloud.post_detach_disk(vm_id, disk_id).body
            vcloud.process_task(task)
          end

          arg :vm_id
          arg :disk_id

          description "
          "

          go!

        end
      end

    end
  end
end
