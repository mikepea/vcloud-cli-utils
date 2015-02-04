module Vcloud
  module CLI
    module Utils
      class GetVmsAttachedToDisk

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |disk_id|
            Fog.mock! if ENV['FOG_MOCK']
            disk = Vcloud::Core::IndependentDisk.new(disk_id)
            disk.attached_vms.each do |vm|
              puts vm.name + " " + vm.id
            end
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

