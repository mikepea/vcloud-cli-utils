require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class DeleteNetwork

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |identifier|
            vcloud = ::Fog::Compute::VcloudDirector.new
            if identifier =~ /^[-0-9a-f]+/
              net = Vcloud::Core::OrgVdcNetwork.new(identifier)
            end
            Fog.mock! if ENV['FOG_MOCK']
            task = vcloud.delete_network(net.id).body
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
