require 'methadone'
require 'vcloud/core'
require 'pp'

module Vcloud
  module CLI
    module Utils
      class MakeVappTemplate

        include Methadone::Main
        include Methadone::CLILogging

        def self.run

          main do |vdc_name, blank_vapp_template_id, iso_id, template_name|

            vcloud = ::Fog::Compute::VcloudDirector.new
            Fog.mock! if ENV['FOG_MOCK']

            vdc = Vcloud::Core::Vdc.get_by_name(vdc_name)

            # Instantiate a 'blank vApp':
            #  * contains one VM
            #  * this VM has a single HDD
            #  * the VM HDD is blank
            puts "Instantiating blank vApp/VM"
            vapp = Vcloud::Core::Vapp.instantiate(
              'make_vapp_template_temp_vapp',
              ['VappCreationTesting'],
              blank_vapp_template_id,
              vdc_name,
            )

            child_vm_id = vapp.fog_vms.first[:href].split('/').last
            vm = Vcloud::Core::Vm.new(child_vm_id, vapp)
            puts "Found child VM id: #{vm.id}"

            # Add our ISO to the VM inside the vApp
            puts "Inserting ISO into VM"
            task = vcloud.post_insert_cd_rom(vm.id, iso_id).body
            vcloud.process_task(task)

            puts "Powering on vApp to install OS"
            vapp.power_on

            # vapp will now boot. VM will be shut down at the end
            puts "Waiting for OS to install"
            while vapp.vcloud_attributes[:status].to_i == 4
              # vapp is in RUNNING state, so OS is still installing
              printf('.')
              sleep(5)
            end
            puts ""

            puts "Removing ISO from VM"
            task = vcloud.post_eject_cd_rom(vm.id, iso_id).body
            vcloud.process_task(task)

            puts "Stopping vApp completely"
            options = { :UndeployPowerAction => 'shutdown' }
            task = vcloud.post_undeploy_vapp(vapp.id, options).body
            vcloud.process_task(task)

            puts "Turn the newly provisioned vApp into a vAppTemplate (in vDC #{vdc_name})"
            capture_body = vcloud.post_capture_vapp(vdc.id, template_name, vapp.id).body
            #vcloud.process_task(task)
            pp capture_body

          end

          arg :vdc_id
          arg :empty_vapp_template_id
          arg :iso_name
          arg :template_name

          description "
          "

          go!

        end
      end

    end
  end
end
