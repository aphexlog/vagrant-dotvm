# DotVm

## How to start using DotVm
First you need to install DotVm plugin:
```
$ vagrant plugin install vagrant-dotvm
```

Then create Vagrantfile like that:
```ruby
require 'vagrant-dotvm'

Vagrant.configure(2) do |config|
  config_path = File.dirname(File.expand_path(__FILE__)) + "/config"
  dotvm = VagrantPlugins::Dotvm::Dotvm.new config_path
  dotvm.inject(config)
end
```

Prepare directory for storing your projects:
```
$ mkdir -p config/projects
```

## How to configure machine
You need to create folder named after your project in `config/projects`.
In this folder you can create as many YAML files as you want.
In each one you are able to define multiple machines.
Where it makes sense you can use %project.path% variable which will be replaced with
path to directory where you project lives.

Example YAML configuration:
```yaml
machines:
  - nick: example
    name: machine1.example
    box: chef/centos-7.0
    networks:
      - net: private_network
        ip: 192.168.56.100
        mask: 255.255.255.0
    provision:
      - type: shell
        path: "%project.path%/bootstrap.sh"
    shared_folders:
      - host: /Volumes/Repos
        guest: /srv/www
```
