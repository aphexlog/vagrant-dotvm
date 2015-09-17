module VagrantPlugins
  module Dotvm
    module Injector
      # Injects DotVm authorized key configuration into Vagrant
      module AuthorizedKey
        extend AbstractInjector

        module_function

        def inject(key: nil, machine: nil)
          if key.type == 'file'
            pubkey = File.readlines(File.expand_path(key.path)).first.strip
          elsif key.type == 'static'
            pubkey = key.key
          end

          machine.vm.provision 'shell' do |s|
            s.path       = "#{UTILS_PATH}/authorize_key.sh"
            s.args       = [pubkey]
            s.privileged = false
            s.name       = "authorized ssh key #{pubkey.split[2]}"
          end
        end
      end
    end
  end
end
