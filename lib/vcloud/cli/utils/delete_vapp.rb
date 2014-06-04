require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class DeleteVapp

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |identifier|
            vcloud = ::Fog::Compute::VcloudDirector.new
            if identifier =~ /^vapp-[-0-9a-f]+/
              vapp = Vcloud::Core::Vapp.new(identifier)
            else
              vapp = Vcloud::Core::Vapp.get_by_name(identifier)
            end
            Fog.mock! if ENV['FOG_MOCK']
            if options[:force]
              task = vcloud.post_undeploy_vapp(vapp.id).body
              vcloud.process_task(task)
            end
            task = vcloud.delete_vapp(vapp.id).body
            vcloud.process_task(task)
          end

          arg :identifier

          on("-f", "--force", "Force deletion of running vapp")

          description "
          "

          go!

        end
      end

    end
  end
end
