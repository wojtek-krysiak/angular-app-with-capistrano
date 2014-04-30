# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box      = 'precise64'
  config.vm.box_url  = 'http://files.vagrantup.com/precise64.box'

  config.berkshelf.enabled = true #setup berkshelf as cookbooks provider
  config.vm.network :forwarded_port, host: 4569, guest: 9000
  config.vm.synced_folder ".", "/vagrant", nfs: true
  config.vm.network "private_network", ip: "192.168.50.4" #has to be added to nfs to work (with example ip)

  # config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | sudo bash"

  config.vm.provision :chef_solo do |chef|
    # chef.cookbooks_path = 'chef/cookbooks'
    # chef.roles_path = "chef/roles"
    
    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "ruby_build"
    chef.add_recipe "rvm::system"
    chef.add_recipe "rvm::user"
    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "nodejs"
    chef.add_recipe "mysql::server"
    chef.add_recipe "mysql::client"

    chef.json = {
      'rvm' => {
        'user_installs' => [
            { 'user'          => 'vagrant',
              'default_ruby'  => '2.1.1',
              'rubies'        => ['2.1.1'],
              'global'        => '2.1.1'
            }
          ]
        },
      'mysql' => {
        'server_root_password' => "rootpass",
        'server_repl_password' => "rootpass",
        'server_debian_password' => "rootpass"
        }
      }

      # sudo -u postgres psql postgres

  end
end