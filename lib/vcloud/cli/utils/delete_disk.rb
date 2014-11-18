require 'methadone'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class DeleteDisk

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |disk_id|
            vcloud = ::Fog::Compute::VcloudDirector.new
            Fog.mock! if ENV['FOG_MOCK']
            task = vcloud.delete_disk(disk_id).body
            vcloud.process_task(task)
          end

          arg :disk_id

          description "
          "

          go!

        end
      end

    end
  end
end
