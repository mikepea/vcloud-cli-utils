require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class RenameVm

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |identifier, name|
            Fog.mock! if ENV['FOG_MOCK']
            if identifier =~ /^vm-[-0-9a-f]+/
              vapp = Vcloud::Core::Vapp.get_by_child_vm_id(identifier)
              vm = Vcloud::Core::Vm.new(identifier, vapp)
            elsif identifier =~ /^vapp-[-0-9a-f]+/
              vapp = Vcloud::Core::Vapp.new(identifier)
              vm_href = vapp.vms.first.fetch(:href)
              vm = Vcloud::Core::Vm.new(vm_href.split('/').last, vapp)
            else
              vapp = Vcloud::Core::Vapp.get_by_name(identifier)
              vm_href = vapp.vms.first.fetch(:href)
              vm = Vcloud::Core::Vm.new(vm_href.split('/').last, vapp)
            end

            if options[:rename_to_match_vapp]
              new_name = vapp.name
            else
              if name.nil?
                raise "Need a name to rename the VM to!"
              else
                new_name = name
              end
            end

            vm.update_name(new_name)

          end

          arg :identifier
          arg :name, :optional

          on("-r", "--rename_to_match_vapp", "Make the vm name match the vApp name")

          description "
Renames a vCloud VM given by :identifier (existing name or ID).

If a 'name' parameter is specified, renames to that.

If --rename_to_match_vapp is specified, treat the identifier as a selector of the vApp, and
rename the VM to that.

If a vApp with multiple VMs is given, only the first is renamed.
"

          go!

        end
      end

    end
  end
end
