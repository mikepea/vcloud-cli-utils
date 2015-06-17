require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class StopVapp

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
            options = { :UndeployPowerAction => 'shutdown' }
            task = vcloud.post_undeploy_vapp(vapp.id, options).body
            vcloud.process_task(task)
          end

          arg :identifier

          description "
          "

          go!

        end
      end

    end
  end
end
