Vagrant.configure("2") do |config|
config.vm.provision "shell", inline: "echo Hello"

config.vm.define "puppet" do |puppet_server|
puppet_server.vm.box = "centos/7"
config.vm.network "private_network", type: "dhcp", adapter: "1", auto_config: false
end

config.vm.define "nginx" do |nginx|
nginx.vm.box = "centos/7"
config.vm.network "private_network", type: "dhcp", adapter: "1", auto_config: false
end

config.vm.synced_folder '.', '/vagrant', disabled: true 
end
