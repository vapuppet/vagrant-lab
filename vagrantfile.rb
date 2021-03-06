Vagrant.configure("2") do |config|
  servers=[
      {
        :hostname => "Puppet",
        :box => "centos/7",
        :ip => "192.168.59.2",
        :ssh_port => '2200'
      },
      {
        :hostname => "Server2",
        :box => "bento/ubuntu-18.04",
        :ip => "192.168.59.3",
        :ssh_port => '2201'
      },
      {
        :hostname => "Server3",
        :box => "centos/7",
        :ip => "192.168.59.4",
        :ssh_port => '2202'
      }
    ]

  servers.each do |machine|
      config.vm.define machine[:hostname] do |node|
          node.vm.box = machine[:box]
          node.vm.hostname = machine[:hostname]
          node.vm.network :private_network, ip: machine[:ip], name: "vboxnet3"
          node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
          node.vm.provider :virtualbox do |vb|
              vb.customize ["modifyvm", :id, "--memory", 1024]
              vb.customize ["modifyvm", :id, "--cpus", 2]
          end
      end
  end
end
