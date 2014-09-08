# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "otium360-devenv"

  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  config.vm.provision "shell" do |shell|
    shell.path       = "puppet-install.sh"
  end

  # Copy local Downloads folder to avoid downloading via wget
  # Useful to speed up testing
  # config.vm.provision "file" do |file|
  #   file.source      = "Downloads"
  #   file.destination = "/home/vagrant"
  # end

  config.vm.provision "puppet" do |puppet|
    puppet.working_directory	= "/vagrant"
    puppet.module_path 				= "modules"
    puppet.options            = "--confdir=conf"
    puppet.hiera_config_path	= "conf/vagrant-hiera.yaml"
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # config.vm.network "forwarded_port", guest: 27017, host: 27017
  # config.vm.synced_folder "/host/folder", "/guest/folder"

end
